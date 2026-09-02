import 'package:pharmacy_management/feature/dashboard/data/model/low_Stock_medicine_model.dart';
import 'package:pharmacy_management/feature/dashboard/data/model/sales_model.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';

class DashboardDataModel extends DashboardData {
  const DashboardDataModel({
    required super.totalMedicines,
    required super.lowStokeCount,
    required super.lowStockMedicines,
    required super.sales,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      totalMedicines: json['"total_medicines'] as int,
      lowStokeCount: json['low_stock_count'] as int,
      lowStockMedicines: (json['low_stock_medicines'] as List<dynamic>)
          .map((item) => LowStockMedicineModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      sales: SalesModel.fromJson(json['today_sales'] as Map<String, dynamic>),
    );
  }

}