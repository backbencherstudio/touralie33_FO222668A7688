import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/sources/local/shared_preference/shared_preference.dart';
import 'api_endpoints.dart';
import 'error_handle.dart';
import 'response_handle.dart';



class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );
  static Map<String, String>? headers;

  static Future <void> headerSet(String? token) async {
    final tokn = await SharedPreferenceData.getToken();
    log(token ?? 'token');
    log(tokn ?? 'tokn');
    headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (tokn != null) 'Authorization': 'Bearer $tokn',
    };
  }

 Future<dynamic> getRequest({
    required String endpoints,
  
  }) async {
   
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.get(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
 
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('GET request failed: $endpoints status=$status data=$data', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (GET): $e', stackTrace: st);
        throw Exception(e.toString());
      }
    }
  }


   Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,

    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
  
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('POST request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (POST): $e', stackTrace: st);
        throw Exception(e.toString());
      }
    }
  }


   Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('PUT request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (PUT): $e', stackTrace: st);
        throw Exception(e.toString());
      }
    }
  }

   Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
 
    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.patch(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ??
              {
                "Content-Type": formData != null
                    ? "multipart/form-data"
                    : "application/json",
              },
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('PATCH request failed: $endpoints status=$status data=$data body=$body', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (PATCH): $e', stackTrace: st);
        throw Exception(e.toString());
      }
    }
  }

  /// PATCH request
   Future<dynamic> deleteRequest({
    required String endpoints,

    // Map<String, String>? headers,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e, st) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        final status = e.response?.statusCode;
        final data = e.response?.data;
        log('DELETE request failed: $endpoints status=$status data=$data', stackTrace: st);
        rethrow;
      } else {
        log('Non-Dio error (DELETE): $e', stackTrace: st);
        throw Exception(e.toString());
      }
    }
  }
}
