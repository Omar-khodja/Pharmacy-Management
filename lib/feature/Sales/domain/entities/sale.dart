import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/cashier.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_item.dart';

class Sale extends Equatable {
  final int id;
  final String invoiceNumber;
  final Cashier cashier;
  final double subtotal;
  final double total;
  final String paymentMethod;
  final String status;
  final List<SaleItem> items;
  final DateTime createdAt;

  const Sale({
    required this.id,
    required this.invoiceNumber,
    required this.cashier,
    required this.subtotal,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.items,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    cashier,
    subtotal,
    total,
    paymentMethod,
    status,
    items,
    createdAt,
  ];
}
