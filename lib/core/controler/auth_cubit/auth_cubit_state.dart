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
  final bool isTokenExpired;
  final bool isAccountInactive;
  final bool isValidationError;
  UnAuthorized({
    required this.message,
    this.isAccountInactive = false,
    this.isTokenExpired = false,
    this.isValidationError = false,
  });
}
