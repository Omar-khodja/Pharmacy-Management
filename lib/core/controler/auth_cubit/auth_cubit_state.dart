import 'package:pharmacy_management/core/entities/authstate.dart';

sealed class AuthCubitState {
  const AuthCubitState();
}

class AuthInitial extends AuthCubitState {
  const AuthInitial();
}

class AuthLoading extends AuthCubitState {
  const AuthLoading();
}

class Authorized extends AuthCubitState {
  final Authstate authstate;

  const Authorized(this.authstate);
}

class UnAuthorized extends AuthCubitState {
  final String message;
  final int? statusCode;

  const UnAuthorized({required this.message, this.statusCode});
}
