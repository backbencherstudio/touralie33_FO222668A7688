import 'package:dio/dio.dart';


class ErrorHandle {
  static String handleDioError(DioException e) {
    final responseData = e.response?.data;
    final serverMessage = _extractMessage(responseData);

    switch (e.type) {
      case DioExceptionType.badCertificate:
        return "Bad certificate. Please try again.";
      case DioExceptionType.badResponse:
        if (serverMessage != null && serverMessage.isNotEmpty) {
          return serverMessage;
        }
        if (e.response != null && e.response?.data != null) {
          return "Server error: ${e.response?.statusCode}";
        }
        return "Server error: ${e.message}";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "Connection error. Please check your internet.";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout. Please try again.";
      case DioExceptionType.unknown:
        return serverMessage ?? "Unknown error occurred. Please try again.";
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'];
      if (message != null) {
        return message.toString();
      }
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return null;
  }
}
