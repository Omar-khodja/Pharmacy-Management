import 'package:pharmacy_management/core/entities/user.dart';

class Authstate {
  Authstate({required this.token,required this.user});
  final String token;
  final User user;

  Authstate copyWith(String? token, User? user) {
    return Authstate(token: token ?? this.token, user: user ?? this.user);
  }
}
