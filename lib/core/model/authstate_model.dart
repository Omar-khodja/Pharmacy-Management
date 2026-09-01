import 'package:pharmacy_management/core/entities/authstate.dart';

class AuthstateModel extends Authstate {
  AuthstateModel({super.token, super.user});
  factory AuthstateModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    return AuthstateModel(token: data["token"], user: data["user"]);
  }
}
