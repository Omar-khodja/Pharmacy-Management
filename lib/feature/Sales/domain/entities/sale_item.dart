import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/medicine_sale.dart';

class SaleItem extends Equatable {
  final int id;
  final int medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;
  final double total;
  final MedicineSale medicine;

  const SaleItem({
    required this.id,
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.medicine,
  });

  @override
  List<Object?> get props => [
    id,
    medicineId,
    medicineName,
    quantity,
    unitPrice,
    total,
    medicine,
  ];
}
