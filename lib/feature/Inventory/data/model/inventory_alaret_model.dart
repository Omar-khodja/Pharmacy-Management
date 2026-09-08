import 'package:pharmacy_management/core/model/medicien_model.dart';
import 'package:pharmacy_management/feature/Inventory/domain/entities/inventory_alaret.dart';

class InventoryAlaretModel extends InventoryAlaret {
  const new({
    required super.expired,
    required super.expiredSoon,
    required super.lowStock,
  });

  factory InventoryAlaretModel.fromJson(Map<String, dynamic> json) {
    return InventoryAlaretModel(
      expired: (json["expired"] as List).map((item) => MedicienModel.fromJson(item) ,).toList(),
      expiredSoon: (json["expiring_soon"]as List).map((item) => MedicienModel.fromJson(item) ,).toList(),
      lowStock: (json["low_stock"]as List).map((item) => MedicienModel.fromJson(item) ,).toList(),
    );
  }
}
