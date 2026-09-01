import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/api_error_handler.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Authentication/data/data_source.dart/base_auth_datasource.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class AuthRepoImpl implements BaseAuthRepo {
  AuthRepoImpl({
    required this.datasource,
    required this.tokenStorage,
    required this.apiErrorHandler,
  });
  final BaseAuthDatasource datasource;
  final TokenStorage tokenStorage;
  final ApiErrorHandler apiErrorHandler;
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
      final message = apiErrorHandler.handleError(e.message);
      debugPrint(
        "//////////////////////////////////AuthRepoImpl login server error : ${e.message}",
      );
      return Left(RemoteFailure(message));
    } on AppDioException catch (e) {
      debugPrint(
        "//////////////////////////////////AuthRepoImpl login Dio error : ${e.message}",
      );
      return Left(DioFailure(e.message));
    }
  }

  @override
  Future<Either<AppFailure, String>> longOut() async {
    try {
      final token = await tokenStorage.getToken();
      if (token == null) {
        return Left(RemoteFailure("No token found"));
      }
      final data = await datasource.longOut(token);
      await tokenStorage.deleteToken();
      return Right(data);
    } on RemoteException catch (e) {
      final message = apiErrorHandler.handleError(e.message);
      debugPrint(
        "//////////////////////////////////AuthRepoImpl logout server error : ${e.toString()}",
      );
      return Left(RemoteFailure(message));
    } on AppDioException catch (e) {
      debugPrint(
        "//////////////////////////////////AuthRepoImpl logout Dio error : ${e.message}",
      );
      return Left(DioFailure(e.message));
    }
  }
}
