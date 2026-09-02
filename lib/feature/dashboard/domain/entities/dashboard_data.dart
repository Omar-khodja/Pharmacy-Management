import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/lowstockmedicine.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/sales_data.dart';

class DashboardData extends Equatable {
  final int totalMedicines;
  final int lowStokeCount;
  final List<Lowstockmedicine> lowStockMedicines;
  final SalesData sales;
  

  const DashboardData({
    required this.totalMedicines,
    required this.lowStokeCount,
    required this.lowStockMedicines,
    required this.sales,
  });

  @override
  List<Object?> get props => [totalMedicines, lowStokeCount, lowStockMedicines, sales];
}