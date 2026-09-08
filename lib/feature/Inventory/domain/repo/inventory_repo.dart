import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Inventory/domain/entities/inventory_alaret.dart';

abstract class InventoryRepo {
  Future<Either<AppFailure, InventoryAlaret>> getAlaret();
  Future<Either<AppFailure, String>> updateQuantity(int id , int quantity);
}
