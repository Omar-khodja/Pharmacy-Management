import 'package:pharmacy_management/core/entities/authstate.dart';

abstract class BaseAuthDatasource {
  Future<Authstate> login(String email, String password);
  Future<String> logOut(String token);
  Future<Authstate> getCurrentUser(String token);
}
