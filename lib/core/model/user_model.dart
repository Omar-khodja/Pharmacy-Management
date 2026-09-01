import 'package:pharmacy_management/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(id: user["id"], email: user["email"], name: user["name"]);
  }
}
