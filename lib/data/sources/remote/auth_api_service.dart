import 'dart:developer';
import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/error_handle.dart';
import 'package:dio/dio.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
  Future<bool> register({required String name,required String email,required String password,required String weight,required String height,required String gender,required String dateOfBirth,required String personalization,required String type}) async {
    try {
      final weightNum = num.tryParse(weight.trim());
      final heightNum = num.tryParse(height.trim());
      if (weightNum == null) {
        throw Exception('Invalid weight');
      }
      if (heightNum == null) {
        throw Exception('Invalid height');
      }

      final personalizationList = personalization
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final body ={
        'email': email,
        'name': name,
        'password': password,
        'weight': weightNum,
        'height': heightNum,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'personalization': personalizationList,
        'type': type,
      };
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.register,
      );
      if (response == null) {
        throw Exception('Registration failed: empty response');
      }
      if (response is! Map) {
        throw Exception('Registration failed: unexpected response type ${response.runtimeType}');
      }

      final map = Map<String, dynamic>.from(response);
      log('Register response: $map');

      final success = map['success'] == true;
      if (success) {
        final token = map['authorization']?['access_token'];
        if (token is String && token.isNotEmpty) {
          await SharedPreferenceData.setToken(token);
        }
        return true;
      }

      final message = map['message'];
      if (message is String && message.isNotEmpty) {
        throw Exception(message);
      }
      throw Exception('Registration failed');
    } on DioException catch (e) {
      final message = ErrorHandle.handleDioError(e);
      throw Exception(message);
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final body = {"email": email, "password": password};
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );
      if (response['success'] == true) {
        await SharedPreferenceData.setToken(
          response['authorization']['access_token'],
        );
        final token = await SharedPreferenceData.getToken();
        log("$token");
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
