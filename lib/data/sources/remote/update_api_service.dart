import 'dart:io';

import 'package:dio/dio.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class UpdateApiService {
  ApiClient apiClient;
  UpdateApiService({required this.apiClient});

  Future<bool> updateUser({
    required String name,
    required num weight,
    required num height,
    required String gender,
    File? image,
  }) async {
    try {
      await ApiClient.headerSet(null);
      final profileResponse = await apiClient.patchRequest(
        endpoints: ApiEndpoints.updateUser,
        body: {
          'name': name,
          'weight': weight,
          'height': height,
          'gender': gender,
        },
      );

      final profileOk = profileResponse['success'] == true ||
          profileResponse['status'] == 'success';
      if (!profileOk) {
        return false;
      }

      if (image == null) return true;

      final imageResponse = await apiClient.patchRequest(
        endpoints: ApiEndpoints.updateUser,
        formData: FormData.fromMap({
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        }),
      );

      return imageResponse['success'] == true ||
          imageResponse['status'] == 'success';
    } catch (e) {
      rethrow;
    }
  }
}
