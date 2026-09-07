import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/low_stock_medicien.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/today_sales.dart';

class DashboardData extends Equatable {
  final int totalMedicines;
  final int lowStokeCount;
  final List<LowStockMedicien> lowStockMedicines;
  final TodaySales salesData;

  const DashboardData({
    required this.totalMedicines,
    required this.lowStokeCount,
    required this.lowStockMedicines,
    required this.salesData
  });

  @override
  List<Object?> get props => [
    totalMedicines,
    lowStokeCount,
    lowStockMedicines,
    salesData,
  ];
}
