import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Authentication/data/data_source.dart/base_auth_datasource.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class AuthRepoImpl implements BaseAuthRepo {
  AuthRepoImpl({required this.datasource, required this.tokenStorage});
  final BaseAuthDatasource datasource;
  final TokenStorage tokenStorage;
  @override
  Future<Either<AppFailure, Authstate>> login(
    String email,
    String password,
  ) async {
    try {
      final data = await datasource.login(email, password);
      await tokenStorage.saveToken(data.token!);
      return Right(data);
    } on RemoteException catch (e) {
      return Left(RemoteFailure(e.message));
    }
  }
}
