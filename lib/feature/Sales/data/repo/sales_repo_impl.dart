import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Sales/data/data_source.dart/baes_sales_datasource.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';
import 'package:pharmacy_management/feature/Sales/domain/repo/sales_repo.dart';

class SalesRepoImpl implements SalesRepo {
  final BaesSalesDatasource datasource;
  final TokenStorage tokenStorage;
  new({required this.datasource, required this.tokenStorage});
  @override
  Future<Map<String, dynamic>> createSale(List<Map<String, dynamic>> items) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, SaleEntity>> getSaleDetails(int id) async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.fetchSaleDetails(id, token!);
      return Right(response);
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<AppFailure, List<SaleEntity>>> getSales() async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.fetchSales(token!);
      return Right(response);
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
