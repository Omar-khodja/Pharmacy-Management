import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class LoginUsecase {
  final BaseAuthRepo authDatasource;

  LoginUsecase(this.authDatasource);

  Future<Either<AppFailure, Authstate>> call(String email, String password) async {
    return await authDatasource.login(email, password);
  }
}