import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';


class DashboardData extends Equatable {
  final int totalMedicines;
  final int lowStokeCount;
  final List<Medicine> lowStockMedicines;
  

  const DashboardData({
    required this.totalMedicines,
    required this.lowStokeCount,
    required this.lowStockMedicines,
  });

  @override
  List<Object?> get props => [totalMedicines, lowStokeCount, lowStockMedicines,];
}