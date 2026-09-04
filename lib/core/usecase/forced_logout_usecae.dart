import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/Authentication/domain/repo/base_auth_repo.dart';

class ForcedlogOutUSerCase {
  final BaseAuthRepo _authDatasource;
  new(this._authDatasource);
   Future<Either<AppFailure, String>> call() async {
    return await _authDatasource.forceLogOut();
  }
}
