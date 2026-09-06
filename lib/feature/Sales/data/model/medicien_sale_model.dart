import 'package:pharmacy_management/feature/Sales/domain/entities/medicine_sale.dart';

class MedicienSaleModel extends MedicineSale {
  const new({required super.id, required super.name, required super.unit});
  factory MedicienSaleModel.fromJson(Map<String, dynamic> json) {
    return MedicienSaleModel(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
    );
  }
}
