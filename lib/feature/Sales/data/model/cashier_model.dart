import 'package:pharmacy_management/feature/Sales/domain/entities/cashier.dart';

class CashierModel extends Cashier {
  const new({required super.id, required super.name});

    factory CashierModel.fromJson(Map<String, dynamic> json) {
    return CashierModel(id: json['id'], name: json['name']);
  }
}