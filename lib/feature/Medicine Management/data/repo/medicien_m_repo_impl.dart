import 'package:dart_either/src/dart_either.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/model/medicien_model.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/data/data_source.dart/base_medicien_m_datasource.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/repo/base_medicien_m_repo.dart';

class MedicienMRepoImpl implements BaseMedicienMRepo {
  new({required this.datasource, required this.tokenStorage});
  final TokenStorage tokenStorage;
  final BaseMedicienMDatasource datasource;
  @override
  Future<Either<AppFailure, String>> addMedicien(Medicine medicien) async {
    try {
      final token = await tokenStorage.getToken();
      await datasource.addMedicien(MedicienModel.fromEntitiy(medicien), token!);
      return const Right("Medicien Added Successfully");
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, String>> deletMedicien(int id) async {
    try {
      final token = await tokenStorage.getToken();
      await datasource.deletMedicien(id, token!);
      return const Right("Medicien Deleted Successfully");
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, String>> editeMedicien(
    Medicine medicien,
  ) async {
    try {
      final token = await tokenStorage.getToken();
      await datasource.editeMedicien(
        MedicienModel.fromEntitiy(medicien),
        token!,
        medicien.id,
      );
      return const Right("The modification was successful");
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, Medicine>> getDetails(String id) async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.getDetails(id, token!);
      return Right(response);
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, List<Medicine>>> search(String query) async {
    try {
      final token = await tokenStorage.getToken();
      final response = await datasource.search(query, token!);
      return Right(response);
    } on RemoteException catch (e) {
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      return Left(DioFailure(message: e.message));
    }
  }
}
