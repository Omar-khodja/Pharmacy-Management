import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/authstate.dart';

sealed class AuthCubitState  extends Equatable{
  const AuthCubitState();
    @override
  List<Object?> get props => [];
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
  const UnAuthorized({
    required this.message,
    this.isAccountInactive = false,
    this.isTokenExpired = false,
    this.isValidationError = false,
  });
    @override
  // TODO:  props
  List<Object?> get props => [message,isTokenExpired,isAccountInactive,isValidationError];
}
