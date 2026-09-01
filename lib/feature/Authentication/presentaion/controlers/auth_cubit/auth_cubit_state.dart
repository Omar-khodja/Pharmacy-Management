import 'package:pharmacy_management/core/entities/authstate.dart';

sealed class AuthCubitState {
  const AuthCubitState();
}

class AuthInitial extends AuthCubitState {}

class AuthLoading extends AuthCubitState {}

class AuthSuccess extends AuthCubitState {
  final Authstate authstate;

  const AuthSuccess(this.authstate);
}

class AuthFailure extends AuthCubitState {
  final String message;

  const AuthFailure(this.message);
}

class AuthLoggedOut extends AuthCubitState {}
