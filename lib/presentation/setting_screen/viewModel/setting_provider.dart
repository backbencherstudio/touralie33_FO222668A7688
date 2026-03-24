import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/data/repositories/update_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/update_api_service.dart';

class SettingState {
  final bool isloading;
  final String? errormessage;

  SettingState({required this.isloading, this.errormessage});

  SettingState copyWith({bool? isloading, String? errormessage}) {
    return SettingState(
      isloading: isloading ?? this.isloading,
      errormessage: errormessage ?? this.errormessage,
    );
  }
}

class SettingProvider extends StateNotifier<SettingState> {
  final UpdateRepository repository;

  SettingProvider({required this.repository})
      : super(SettingState(isloading: false));

  Future<bool> updateUser({
    required String name,
    required num weight,
    required num height,
    required String gender,
    File? image,
  }) async {
    state = state.copyWith(isloading: true, errormessage: null);
    try {
      final success = await repository.updateUser(
        name: name,
        weight: weight,
        height: height,
        gender: gender,
        image: image,
      );
      state = state.copyWith(
        isloading: false,
        errormessage: success ? null : 'Failed to update user',
      );
      return success;
    } catch (e) {
      String message = e.toString();
      if (e is DioException) {
        final data = e.response?.data;
        final rawMessage = data is Map ? data['message'] : null;
        if (rawMessage is List) {
          message = rawMessage.join(', ');
        } else if (rawMessage != null) {
          message = rawMessage.toString();
        }
      }
      state = state.copyWith(isloading: false, errormessage: message);
      return false;
    }
  }
}

final settingProvider = StateNotifierProvider<SettingProvider, SettingState>((
  ref,
) {
  return SettingProvider(
    repository: UpdateRepository(
      resource: UpdateApiService(apiClient: ApiClient()),
    ),
  );
});
