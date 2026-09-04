import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/error/failure.dart';

abstract class BaseMedicienMRepo {
  Future<Either<AppFailure, List<Medicine>>> search(String query);
  Future<Either<AppFailure, Medicine>> getDetails(String id);
  Future<Either<AppFailure, String>> addMedicien(Medicine medicien);
  Future<Either<AppFailure, String>> editeMedicien(Medicine medicien);
  Future<Either<AppFailure, String>> deletMedicien(int id);
}
