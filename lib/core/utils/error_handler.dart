import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ErrorHandler {
  static void handleError(
    BuildContext context,
    dynamic error, {
    String? defaultMessage,
    bool silent = false,
  }) {
    if (silent) return;

    String message = defaultMessage ?? 'An error occurred';

    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        return;
      }
      message = _handleDioError(error);
    } else if (error is Exception) {
      message = error.toString();
    }

    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: const Text('Error'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.badResponse:
        if (error.response != null) {
          final data = error.response!.data;
          if (data is Map<String, dynamic>) {
            if (data.containsKey('message')) {
              return data['message'] as String;
            }
            if (data.containsKey('error')) {
              return data['error'] as String;
            }
          }
          return 'Server error: ${error.response!.statusCode}';
        }
        return 'Server error occurred';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.unknown:
        return 'Network error. Please check your connection.';
      default:
        return 'An unexpected error occurred';
    }
  }
}
