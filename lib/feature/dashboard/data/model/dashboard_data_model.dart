import 'package:pharmacy_management/feature/dashboard/data/model/low_stock_medicien_model.dart';
import 'package:pharmacy_management/feature/dashboard/data/model/today_sales_model.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';

class DashboardDataModel extends DashboardData {
  const DashboardDataModel({
    required super.totalMedicines,
    required super.lowStokeCount,
    required super.lowStockMedicines,
    required super.salesData,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      totalMedicines: (json['total_medicines'] ?? 0 )as int ,
      lowStokeCount: (json['low_stock_count'] ?? 0) as int,
      lowStockMedicines: (json['low_stock_medicines'] as List<dynamic>)
          .map(
            (item) =>
                LowStockMedicienModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      salesData: TodaSalesModel.fromJson(json["today_sales"])
    );
  }

}