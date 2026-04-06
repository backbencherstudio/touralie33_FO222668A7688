import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/notification_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/notification_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/notification_api_service.dart';

class NotificationState {
  final bool isloading;
  final String? errormessage;
  final NotificationModel? getData;

  NotificationState({
    this.errormessage,
    required this.isloading,
    this.getData,
  });

  NotificationState copyWith({
    bool? isloading,
    String? errormessage,
    NotificationModel? getData,
  }) {
    return NotificationState(
      isloading: isloading ?? this.isloading,
      errormessage: errormessage ?? this.errormessage,
      getData: getData ?? this.getData,
    );
  }
}

class NotificationProvider extends StateNotifier<NotificationState> {
  final NotificationRepository source;

  NotificationProvider({required this.source})
      : super(NotificationState(isloading: false));

  Future<bool> getNotification() async {
    state = state.copyWith(isloading: true, errormessage: null);
    try {
      final response = await source.notification();
      state = state.copyWith(
        isloading: false,
        errormessage: null,
        getData: response,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        errormessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationProvider, NotificationState>((ref) {
  return NotificationProvider(
    source: NotificationRepository(
      resource: NotificationApiService(apiClient: ApiClient()),
    ),
  );
});
