import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/invoice.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';

abstract class SalesRepo {
  Future<Either<AppFailure, List<SaleEntity>>> getSales();

  Future<Either<AppFailure, SaleEntity>> getSaleDetails(int id);

  Future<Either<AppFailure, String>> createSale(List<Invoice> items);
}
