import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';

class InventoryAlaret extends Equatable {
 const new({
    required this.expired,
    required this.expiredSoon,
    required this.lowStock,
  });
  final List<Medicine> lowStock;
  final List<Medicine> expired;
  final List<Medicine> expiredSoon;
  @override
  List<Object?> get props => [lowStock, expired, expiredSoon];
}
