import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/data/repositories/verify_otp_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/verify_email_servicce.dart';

class OtpState {
  final bool isLoading;
  final String? errorMessage;
  final String? resetToken;

  OtpState({required this.isLoading, this.errorMessage, this.resetToken});

  OtpState copyWith({bool? isLoading, String? errorMessage, String? resetToken}) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resetToken: resetToken ?? this.resetToken,
    );
  }
}

class OtpProvider extends StateNotifier<OtpState> {
  final VerifyOtpRepository repository;

  OtpProvider({required this.repository}) : super(OtpState(isLoading: false));

Future<bool> verifyOtp({required String email, required String token}) async {
  state = state.copyWith(isLoading: true, errorMessage: null, resetToken: null);
  try {
    final response = await repository.verifyOtp(email: email, token: token);

    final success = response['success'] == true || response['status'] == 'success';
    
    if (!success) {
      final message = response['message'];
      state = state.copyWith(
        isLoading: false,
        errorMessage: message is String ? message : message?.toString(),
      );
      return false; 
    }

    state = state.copyWith(
      isLoading: false, 
      resetToken: response['resetToken'], 
    );
    return true; 

  } catch (e) {
    state = state.copyWith(isLoading: false, errorMessage: e.toString());
    return false;
  }
}}

final otpProvider = StateNotifierProvider<OtpProvider, OtpState>((ref) {
  return OtpProvider(
    repository: VerifyOtpRepository(
      resource: VerifyEmailServicce(apiClient: ApiClient()),
    ),
  );
});
