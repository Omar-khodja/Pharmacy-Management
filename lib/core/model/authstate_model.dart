import 'package:pharmacy_management/core/entities/authstate.dart';
import 'package:pharmacy_management/core/model/user_model.dart';

class AuthstateModel extends Authstate {
  AuthstateModel({required super.token, required super.user});
  factory AuthstateModel.fromJson(Map<String, dynamic> json) {
    final data =  json["data"];
    return AuthstateModel(token: data["token"] ?? "", user: UserModel.fromJson(data["user"]));
  }
    factory AuthstateModel.fromgetCurrentuser(Map<String, dynamic> json) {
    final data = json["data"];
    return AuthstateModel(
      token: data["token"] ?? "",
      user: UserModel.fromJson(data),
    );
  }
}
