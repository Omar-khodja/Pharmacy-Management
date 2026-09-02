import 'package:pharmacy_management/feature/dashboard/domain/entities/lowstockmedicine.dart';

class LowStockMedicineModel extends Lowstockmedicine{
  const LowStockMedicineModel({
    required super.id,
    required super.name,
    required super.quantity,
  });

  factory LowStockMedicineModel.fromJson(Map<String, dynamic> json) {
    return LowStockMedicineModel(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
    );
  }
}