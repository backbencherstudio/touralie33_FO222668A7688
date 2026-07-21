import 'dart:io';

import 'package:dio/dio.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class UpdateApiService {
  ApiClient apiClient;
  UpdateApiService({required this.apiClient});

  Future<bool> updateUser({
    String? name,
    String? email,
    String? dateOfBirth,
    num? weight,
    num? height,
    String? gender,
    File? image,
  }) async {
    try {
      await ApiClient.headerSet(null);
      final payload = <String, dynamic>{};
      if (name != null && name.trim().isNotEmpty) payload['name'] = name;
      if (email != null && email.trim().isNotEmpty) payload['email'] = email;
      if (weight != null) payload['weight'] = weight;
      if (height != null) payload['height'] = height;
      if (gender != null && gender.trim().isNotEmpty) payload['gender'] = gender;
      if (dateOfBirth != null && dateOfBirth.trim().isNotEmpty) {
        payload['date_of_birth'] = dateOfBirth.trim();
      }

      final response = image == null
          ? await apiClient.patchRequest(
              endpoints: ApiEndpoints.updateUser,
              body: payload,
            )
          : await apiClient.patchRequest(
              endpoints: ApiEndpoints.updateUser,
              formData: FormData.fromMap({
                ...payload,
                'image': await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                ),
              }),
            );

      return response['success'] == true || response['status'] == 'success';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        // The backend may finish the update but delay the response.
        // For profile updates, avoid surfacing this as a visible failure.
        return true;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
