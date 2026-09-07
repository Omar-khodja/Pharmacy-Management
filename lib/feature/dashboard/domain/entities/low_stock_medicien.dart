import 'package:equatable/equatable.dart';

class LowStockMedicien extends Equatable {
  const new({required this.id, required this.name, required this.quantity});
  final int id;
  final String name;
  final int quantity;
  @override
  List<Object?> get props => [id, name, quantity];

  factory  LowStockMedicien.empty() {
    return const LowStockMedicien(id: 1, name: "name", quantity: 0);
  }
}
