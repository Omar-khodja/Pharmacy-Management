import 'package:flutter/rendering.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/dashboard/data/data_source.dart/base_dashboard_datasource.dart';
import 'package:pharmacy_management/feature/dashboard/data/model/dashboard_data_model.dart';

class DashboardRemoteDatasource extends BaseDashboardDatasource {
  DashboardRemoteDatasource({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<DashboardDataModel> getDashboardData(String token) async {
    try {
      final response = await apiClient.get('/dashboard', token);

      debugPrint(
        '////////////////////Dashboard data: ${response.data["data"]}',
      );
      return DashboardDataModel.fromJson(response.data["data"]);
    } catch (e) {
      debugPrint('////////////////////Dashboard data error: $e');
      rethrow;
    }
  }
}
