import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Inventory/domain/entities/inventory_alaret.dart';
import 'package:pharmacy_management/feature/Inventory/domain/repo/inventory_repo.dart';

class GetAlaretUsecase {
  new({required this.repo});
  final InventoryRepo repo;
  Future<Either<AppFailure, InventoryAlaret>> call() async {
    return await repo.getAlaret();
  }
}
