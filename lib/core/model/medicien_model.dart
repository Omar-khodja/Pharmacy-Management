import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/model/category_model.dart';

class MedicienModel extends Medicine {
  const MedicienModel({
    required super.id,
    required super.name,
    required super.categoryId,
    required super.category,
    required super.price,
    required super.quantity,
    required super.minStockLevel,
    required super.expiryDate,
    required super.expiryStatus,
    required super.isLowStock,
    required super.isExpired,
    required super.isExpiringSoon,
  });

  factory MedicienModel.fromJson(Map<String, dynamic> json) {
    return MedicienModel(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      category: CategoryModel.fromJson(json['category']),
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] ?? 0) as int,
      minStockLevel: json['min_stock_level'],
      expiryDate: DateTime.parse(json['expiry_date']),
      expiryStatus: json['expiry_status'],
      isLowStock: json['is_low_stock'],
      isExpired: json['is_expired'],
      isExpiringSoon: json['is_expiring_soon'],
    );
  }
  Map<String, dynamic> toAddJson() {
    return {
      "categoryId": categoryId,
      "name": name,
      "price": price,
      "quantity": quantity,
      "expiryDate": expiryDate.toIso8601String(),
    };
  }
  Map<String, dynamic> toEditJson() {
    return {
      "categoryId": categoryId,
      "name": name,
      "price": price,
      "expiryDate": expiryDate.toIso8601String(),
    };
  }

  factory MedicienModel.fromEntitiy(Medicine medicien) {
    return MedicienModel(
      id: medicien.id,
      name: medicien.name,
      categoryId: medicien.categoryId,
      category: medicien.category,
      price: medicien.price,
      quantity: medicien.quantity,
      minStockLevel: medicien.minStockLevel,
      expiryDate: medicien.expiryDate,
      expiryStatus: medicien.expiryStatus,
      isLowStock: medicien.isLowStock,
      isExpired: medicien.isExpired,
      isExpiringSoon: medicien.isExpiringSoon,
    );
  }
}
