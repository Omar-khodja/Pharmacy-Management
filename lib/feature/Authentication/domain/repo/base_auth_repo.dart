import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/error/failure.dart';

abstract class BaseAuthRepo {
  Future<Either<AppFailure, Authstate>> login(String email, String password);
  Future<Either<AppFailure, String>> logOut();
  Future<Either<AppFailure, String>> forceLogOut();
}