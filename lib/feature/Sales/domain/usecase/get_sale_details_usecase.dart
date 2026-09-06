import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/sale_entity.dart';
import 'package:pharmacy_management/feature/Sales/domain/repo/sales_repo.dart';

class GetSaleDetailsUsecase {
  final SalesRepo repo;
  new({required this.repo});
  Future<Either<AppFailure, SaleEntity>> call(int id) async{
    return await repo.getSaleDetails(id);
  }
}
