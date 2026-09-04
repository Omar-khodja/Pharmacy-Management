import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
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
      debugPrint(
        "//////////////////////////////////AuthRepoImpl login server error : ${e.message}",
      );
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      debugPrint(
        "//////////////////////////////////AuthRepoImpl login Dio error : ${e.message}",
      );
      return Left(DioFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> logOut() async {
    try {
      final token = await tokenStorage.getToken();
      if (token == null) {
        return Left(LocalStorageFailure(message: "No token found"));
      }
      await datasource.longOut(token);
      await tokenStorage.deleteToken();
      return const Right("Logged Out Successfully");
    } on RemoteException catch (e) {
      debugPrint(
        "//////////////////////////////////AuthRepoImpl logout server error : ${e.toString()}",
      );
      return Left(RemoteFailure(message: e.message, statusCode: e.statusCode));
    } on AppDioException catch (e) {
      debugPrint(
        "//////////////////////////////////AuthRepoImpl logout Dio error : ${e.message}",
      );
      return Left(DioFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> forceLogOut() async {
    try {
      final token = await tokenStorage.getToken();
      if (token == null) {
        return Left(LocalStorageFailure(message: "No token found"));
      }
      await tokenStorage.deleteToken();
      return const Right("Token Expired Login Again");
    } catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}
