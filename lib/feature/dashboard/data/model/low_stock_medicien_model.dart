import 'package:pharmacy_management/feature/dashboard/domain/entities/low_stock_medicien.dart';

class LowStockMedicienModel extends LowStockMedicien {
  const new({required super.id, required super.name, required super.quantity});
  factory LowStockMedicienModel.fromJson(Map<String, dynamic> json) {
    return LowStockMedicienModel(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"],
    );
  }
}
