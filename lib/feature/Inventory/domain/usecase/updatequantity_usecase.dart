import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Inventory/domain/repo/inventory_repo.dart';

class UpdatequantityUsecase {
  new({required this.repo});
  final InventoryRepo repo;
  Future<Either<AppFailure, String>> call(int id, int quntity) async {
    return await repo.updateQuantity(id, quntity);
  }
}
