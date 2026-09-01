import 'package:pharmacy_management/core/entities/authstate.dart';

abstract class BaseAuthDatasource {
  Future<Authstate> login(String email, String password);
  Future<String> longOut(String token);
}
