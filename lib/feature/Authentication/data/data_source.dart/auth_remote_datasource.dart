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
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint("AuthRemoteDatasource login response data: $data");
        if (data["success"] == true) {
          return AuthstateModel.fromJson(data);
        } else {
          throw RemoteException('Login failed: ${data["message"]}');
        }
      } else {
        throw RemoteException('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data?["message"];
      throw AppDioException(serverMessage ?? "Network error: ${e.message}");
    } catch (e) {
      throw RemoteException('$e');
    }
  }

  @override
  Future<String> longOut(String token) async {
    try {
      final response = await apiClient.postWithToken("/auth/logout", token,null);
      debugPrint(
        "///////////////////////////////////AuthRemoteDatasource logout response data: $response",
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data["success"] == true) {
          return "Logout successful";
        } else {
          throw RemoteException('Logout failed: ${data["message"]}');
        }
      } else {
        throw RemoteException('Failed to logout: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data?["message"];
      throw AppDioException(serverMessage ?? "Network error: ${e.message}");
    } catch (e) {
      throw RemoteException('$e');
    }
  }
}
