import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/model/authstate_model.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Authentication/data/data_source.dart/base_auth_datasource.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';

class AuthRemoteDatasource implements BaseAuthDatasource {
  final ApiClient apiClient;
  AuthRemoteDatasource(this.apiClient);
  @override
  Future<Authstate> login(String email, String password) async {
    try {
      final response = await apiClient.authLogin({
        "email": email,
        "password": password,
      });

      final data = response.data;
      debugPrint("AuthRemoteDatasource login response data: $data");
      return AuthstateModel.fromJson(data);
    } on DioException catch (e) {
      debugPrint("log in exceptions $e");
      rethrow;
    }
  }

  @override
  Future<String> longOut(String token) async {
    try {
      final response = await apiClient.postWithToken(
        "/auth/logout",
        token,
        null,
      );
      debugPrint(
        "///////////////////////////////////AuthRemoteDatasource logout response data: $response",
      );

      return "Logout successful";
    } on DioException catch (e) {
      final serverMessage = e.response?.data?["message"];
      throw AppDioException(serverMessage ?? "Network error: ${e.message}");
    } catch (e) {
      debugPrint("logout exceptions $e");

      rethrow;
    }
  }
}
