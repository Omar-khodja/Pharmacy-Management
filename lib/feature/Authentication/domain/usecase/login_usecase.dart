import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class LoginUsecase {
  final BaseAuthRepo _authDatasource;

  LoginUsecase(this._authDatasource);

  Future<Either<AppFailure, Authstate>> call(String email, String password) async {
    return await _authDatasource.login(email, password);
  }
}