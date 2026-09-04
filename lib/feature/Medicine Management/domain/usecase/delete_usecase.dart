import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/repo/base_medicien_m_repo.dart';

class DeleteUsecase {
  final BaseMedicienMRepo repository;

  DeleteUsecase(this.repository);

  Future<Either<AppFailure, String>> call(int id) async {
    return await repository.deletMedicien(id);
  }
}
