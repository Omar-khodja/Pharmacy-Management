import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/invoice.dart';
import 'package:pharmacy_management/feature/Sales/domain/repo/sales_repo.dart';

class CreateSaleUsecase {
  final SalesRepo repo;
  new({required this.repo});
  Future<Either<AppFailure, String>> call(List<Invoice> invoice) async{
    return await repo.createSale(invoice);
  }
}
