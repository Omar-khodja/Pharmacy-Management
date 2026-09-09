import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/medicine.dart';

  class InventoryAlaret extends Equatable {
  const new({
      required this.expired,
      required this.expiredSoon,
      required this.lowStock,
    });
    final List<Medicine> lowStock;
    final List<Medicine> expired;
    final List<Medicine> expiredSoon;
      factory InventoryAlaret.empty() {
      return const InventoryAlaret(expired: [], expiredSoon: [], lowStock: []);
    }
      InventoryAlaret copyWith({
    List<Medicine>? lowStock,
    List<Medicine>? expired,
    List<Medicine>? expiredSoon,
  }) {
    return InventoryAlaret(
      lowStock: lowStock ?? this.lowStock,
      expired: expired ?? this.expired,
      expiredSoon: expiredSoon ?? this.expiredSoon,
    );
  }
    @override
    List<Object?> get props => [lowStock, expired, expiredSoon];
  }
