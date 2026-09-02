import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/dashboard/data/data_source.dart/base_dashboard_datasource.dart';
import 'package:pharmacy_management/feature/dashboard/data/model/dashboard_data_model.dart';

class DashboardRemoteDatasource extends BaseDashboardDatasource {
  DashboardRemoteDatasource({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<DashboardDataModel> getDashboardData(String token) async {
    try {
      final response = await apiClient.getWithToken('/dashboard', token);
      if (response.statusCode != 200) {
        throw RemoteException('Failed to load dashboard data');
      }
      debugPrint('////////////////////Dashboard data: ${response.data}');
      return DashboardDataModel.fromJson(response.data);
    }on DioException catch (e) {
      final serverMessage = e.response?.data?["message"];
      throw AppDioException(serverMessage ?? "Network error: ${e.message}");
    } catch (e) {
      debugPrint('////////////////////Dashboard data error: $e');
      throw RemoteException('$e');
    }
  }
}
