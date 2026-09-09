import 'package:flutter/rendering.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/model/authstate_model.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Authentication/data/data_source.dart/base_auth_datasource.dart';

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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> logOut(String token) async {
    try {
       await apiClient.post(
        "/auth/logout",
        token,
        null,
      );
   

      return "Logout successful";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Authstate> getCurrentUser(String token)async {
    try {
      final response = await apiClient.get("/auth/me",token);

      final data = response.data;
      debugPrint("////////////////////////////////////Current User: $data");
      return AuthstateModel.fromgetCurrentuser(data);
    } catch (e) {
      rethrow;
    }
  }
}
