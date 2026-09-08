import 'package:dart_either/src/dart_either.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Inventory/data/data_source.dart/base_inventory_datasource.dart';
import 'package:pharmacy_management/feature/Inventory/domain/entities/inventory_alaret.dart';
import 'package:pharmacy_management/feature/Inventory/domain/repo/inventory_repo.dart';

class InventoryRepoImpl implements InventoryRepo {
  new({required this.tokenStorage, required this.datasource});
  final TokenStorage tokenStorage;
  final BaseInventoryDatasource datasource;
  @override
  Future<Either<AppFailure, InventoryAlaret>> getAlaret() async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.getAlaret(token!);
      return Right(response);
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<AppFailure, String>> updateQuantity(
    int id,
    int quantity,
  ) async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.updateQuantity(id,quantity,token!);
      return Right(response);
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
