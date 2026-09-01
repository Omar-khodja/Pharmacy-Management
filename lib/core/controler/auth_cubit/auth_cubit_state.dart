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
  final int? statusCode;

  const AuthFailure({required this.message, this.statusCode });
}

class AuthLoggedOut extends AuthCubitState {}
