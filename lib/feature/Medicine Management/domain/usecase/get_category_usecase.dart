import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/category.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/repo/base_medicien_m_repo.dart';

class GetCategoryUseCase {
  final BaseMedicienMRepo repository;

  GetCategoryUseCase(this.repository);

  Future<Either<AppFailure, List<Category>>> call() async {
    return await repository.getCategory();
  }
}
