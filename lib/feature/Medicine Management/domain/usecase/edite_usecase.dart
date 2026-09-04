import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/repo/base_medicien_m_repo.dart';

class EditeUsecase {
  final BaseMedicienMRepo repository;

  EditeUsecase(this.repository);

  Future<Either<AppFailure, String>> call(Medicine medicien) async {
    return await repository.editeMedicien(medicien);
  }
}
