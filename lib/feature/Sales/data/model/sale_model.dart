import 'package:pharmacy_management/feature/Sales/data/model/cashier_model.dart';
import 'package:pharmacy_management/feature/Sales/data/model/sale_item_model.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';

class SaleModel extends SaleEntity {
  const new({
    required super.id,
    required super.invoiceNumber,
    required super.cashier,
    required super.subtotal,
    required super.total,
    required super.paymentMethod,
    required super.status,
    required super.items,
    required super.createdAt,
  });
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      invoiceNumber: json['invoice_number'] ,
      cashier: CashierModel.fromJson(json['cashier']),
      subtotal: (json['subtotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['payment_method'] ,
      status: json['status'] ,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => SaleItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
