import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class VerifyEmailServicce {
  ApiClient apiClient;
  VerifyEmailServicce({required this.apiClient});

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String token,
  }) async {
    final body = {'email': email, 'token': token};
    final dynamic response = await apiClient.postRequest(
      endpoints: ApiEndpoints.checkOtp,
      body: body,
    );

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    return {'success': false, 'message': 'Unexpected response'};
  }

    Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    final body = {'email': email};
    final dynamic response = await apiClient.postRequest(
      endpoints: ApiEndpoints.resendVerificationEmail,
      body: body,
    );

    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    return {'success': false, 'message': 'Unexpected response'};
  }
}
