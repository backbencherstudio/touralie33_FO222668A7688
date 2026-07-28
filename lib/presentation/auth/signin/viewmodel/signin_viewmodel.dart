import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/auth_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';


class SignInState {
  final bool isLoading;
  final String? errorMessage; 
  final bool isUnverified;
  final String? email;

  SignInState({
    required this.isLoading,
    this.errorMessage,
    this.isUnverified = false,
    this.email,
  });

  SignInState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isUnverified,
    String? email,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isUnverified: isUnverified ?? this.isUnverified,
      email: email ?? this.email,
    );
  }
}


class SignInViewModel extends StateNotifier<SignInState> {
  final AuthRepository repository;

  SignInViewModel({required this.repository}) : super(SignInState(isLoading: false));

  Future<bool> signIn({
    required String email,
    required String password,
    String? fcmToken,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isUnverified: false,
      email: null,
    );
    try {
      final success = await repository.login(
        email: email,
        password: password,
        fcmToken: fcmToken,
      );
      state = state.copyWith(isLoading: false); 
      return success;
    } catch (e) {
      final errStr = e.toString();
      if (errStr.contains('UNVERIFIED:')) {
        final parts = errStr.split('UNVERIFIED:');
        final unverifiedEmail = parts.length > 1 ? parts[1].trim() : email;
        state = state.copyWith(
          isLoading: false,
          isUnverified: true,
          email: unverifiedEmail,
        );
        return false;
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}


final signInViewModelProvider = StateNotifierProvider<SignInViewModel, SignInState>((ref) {
  return SignInViewModel(
    repository: AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    ),
  );
});

final eyeSecure = StateProvider<bool>((ref) => true); 
final checkIcon = StateProvider<bool>((ref) => false); 
