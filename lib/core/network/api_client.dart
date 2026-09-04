import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/network/AuthInterceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio, required void Function() onUnauthorized}) {
    dio.options.baseUrl = "https://studiosie.store/sie-api/api/pharmacy";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(AuthInterceptor(onUnauthorized));
  }

  Future<Response> authLogin(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/auth/login", data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> get(String endpoint, String token) async {
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

  Future<Response> post(
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

  Future<Response> put(
    String endpoint,
    String token,
    Map<String, dynamic>? body,
  ) async {
    try {
      final response = await dio.put(
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

   Future<Response> delete(
    String endpoint,
    String token,
  ) async {
    try {
      final response = await dio.delete(
        endpoint,
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
        return "You Account is inactive.";
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
