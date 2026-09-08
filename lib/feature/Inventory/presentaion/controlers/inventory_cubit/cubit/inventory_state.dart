part of 'inventory_cubit.dart';

sealed class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

final class InventoryLoding extends InventoryState {
  const new();
}

final class Inventorydata extends InventoryState {
  final InventoryAlaret alaret;
  final String? message;
  const new({required this.alaret ,this.message});
  @override
  List<Object> get props => [alaret];
}
final class InventoryError extends InventoryState{
    final String? message;
  const new( this.message);
}
