import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale.dart';

abstract class SalesRepo {
  /// Get list of invoices (paginated)
  Future<Either<AppFailure,List<Sale>>> getSales();

  /// Get details of a single invoice
  Future<Either<AppFailure, Sale>> getSaleDetails(int id,);

  /// Create a new sale (invoice)
  Future<Map<String, dynamic>> createSale(List<Map<String, dynamic>> items);
}
