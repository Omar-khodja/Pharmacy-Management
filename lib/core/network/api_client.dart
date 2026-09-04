import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    dio.options.baseUrl = "https://studiosie.store/sie-api/api/pharmacy";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> authLogin(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/auth/login", data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> getWithToken(String endpoint, String token) async {
    try {
      final response = await dio.get(
        endpoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            'Accept': "application/json",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> postWithToken(
    String endpoint,
    String token,
    Map<String, dynamic>? body,
  ) async {
    try {
      final response = await dio.post(
        endpoint,
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.cancel) {
      return AppDioException("Network error ${e.message}");
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final message = _apiErrorhandler(statusCode.toString());
      return RemoteException(message: message, statusCode: statusCode);
    } else {
      return AppDioException(e.message ?? "Unexpected Dio error");
    }
  }

  String _apiErrorhandler(String statusCode) {
    switch (statusCode) {
      case "401":
        return "Unauthorized - token expired";
      case "403":
        return "Account inactive.";
      case "404":
        return "Resource not found.";
      case "422":
        return "Validation error. Please check your Email or password.";
      case "500":
        return "Server error. Please try again later.";
      default:
        return "Unexpected error occurred (code $statusCode).";
    }
  }
}
