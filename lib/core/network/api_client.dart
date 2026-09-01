import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio})   {
    dio.options.baseUrl = "https://studiosie.store/sie-api/api/pharmacy";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> authLogin(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("/auth/login", data: data);
      return response;
    } on DioException catch (e) {
      throw RemoteException(_handleError(e));
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
      throw RemoteException(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Receive timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      return "Server error: ${e.response?.statusCode}";
    } else {
      return "Unexpected error: ${e.message}";
    }
  }
}
