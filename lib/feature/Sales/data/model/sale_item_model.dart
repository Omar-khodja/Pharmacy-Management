import 'package:pharmacy_management/feature/Sales/data/model/medicien_sale_model.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_item.dart';

class SaleItemModel extends SaleItem {
 const  new({
    required super.id,
    required super.medicineId,
    required super.medicineName,
    required super.quantity,
    required super.unitPrice,
    required super.total,
    required super.medicine,
  });
    factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    return SaleItemModel(
      id: json['id'] ,
      medicineId: json['medicine_id']  ,
      medicineName: json['medicine_name'] ?? 'Unkown' ,
      quantity: json['quantity'] ,
      unitPrice: (json['unit_price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      medicine: MedicienSaleModel.fromJson(json['medicine']),
    );
  }
}
