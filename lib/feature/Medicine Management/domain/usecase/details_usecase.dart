import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/medicine.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/repo/base_medicien_m_repo.dart';

class DetailsUsecase {
  final BaseMedicienMRepo repository;

  DetailsUsecase(this.repository);

  Future<Either<AppFailure, Medicine>> call(int id) async {
    return await repository.getDetails(id.toString());
  }
}
