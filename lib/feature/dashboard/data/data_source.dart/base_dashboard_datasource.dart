import 'package:pharmacy_management/feature/dashboard/data/model/dashboard_data_model.dart';

abstract class  BaseDashboardDatasource {
  Future<DashboardDataModel> getDashboardData(String token);
}