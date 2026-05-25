import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/notification_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/notification_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/notification_api_service.dart';

class NotificationState {
  final bool isloading;
  final String? errormessage;
  final NotificationModel? getData;
  final List<String> seenNotificationIds;

  NotificationState({
    this.errormessage,
    required this.isloading,
    this.getData,
    this.seenNotificationIds = const <String>[],
  });

  int get unreadCount {
    final notifications = getData?.data ?? <Data>[];
    if (notifications.isEmpty) return 0;
    return notifications
        .where((item) => item.id != null && !seenNotificationIds.contains(item.id))
        .length;
  }

  bool isRead(Data item) {
    final id = item.id;
    if (id == null || id.isEmpty) return true;
    return seenNotificationIds.contains(id);
  }

  NotificationState copyWith({
    bool? isloading,
    String? errormessage,
    NotificationModel? getData,
    List<String>? seenNotificationIds,
  }) {
    return NotificationState(
      isloading: isloading ?? this.isloading,
      errormessage: errormessage ?? this.errormessage,
      getData: getData ?? this.getData,
      seenNotificationIds: seenNotificationIds ?? this.seenNotificationIds,
    );
  }
}

class NotificationProvider extends StateNotifier<NotificationState> {
  final NotificationRepository source;

  NotificationProvider({required this.source})
      : super(NotificationState(isloading: false));

  Future<void> _loadSeenNotifications() async {
    final seenIds = await SharedPreferenceData.getSeenNotificationIds();
    state = state.copyWith(seenNotificationIds: seenIds);
  }

  Future<bool> getNotification() async {
    state = state.copyWith(isloading: true, errormessage: null);
    try {
      await _loadSeenNotifications();
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

  Future<void> markAllAsRead() async {
    final notifications = state.getData?.data ?? <Data>[];
    final ids = notifications
        .map((item) => item.id)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();
    await SharedPreferenceData.setSeenNotificationIds(ids);
    state = state.copyWith(seenNotificationIds: ids);
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
