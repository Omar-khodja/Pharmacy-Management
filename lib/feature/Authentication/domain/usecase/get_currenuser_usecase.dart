import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class GetCurrenuserUsecase {
  final BaseAuthRepo _authDatasource;

  GetCurrenuserUsecase(this._authDatasource);

  Future<Either<AppFailure, Authstate>> call(

  ) async {
    return await _authDatasource.getCurrentUser();
  }
}
