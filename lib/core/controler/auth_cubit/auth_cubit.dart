import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/usecase/forced_logout_usecae.dart';
import 'package:pharmacy_management/core/usecase/longout_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final LoginUsecase loginUsecase;
  final LongOutUsecase longOutUsecase;
  final ForcedlogOutUSerCase forcedlogOutUSerCase;

  AuthCubit({
    required this.loginUsecase,
    required this.longOutUsecase,
    required this.forcedlogOutUSerCase,
  }) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    final result = await loginUsecase.call(email, password);
    result.fold(
      ifLeft: (failure) =>
          emit(UnAuthorized(message: failure.message, isValidationError: true)),
      ifRight: (authstate) => emit(Authorized(authstate)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await longOutUsecase.call();
    result.fold(
      ifLeft: (failure) =>
          emit(UnAuthorized(message: failure.message, isTokenExpired: true)),
      ifRight: (message) =>
          emit(UnAuthorized(message: message, isTokenExpired: true)),
    );
  }

  Future<void> forcedLogOUt() async {
    emit(const AuthLoading());
    final result = await forcedlogOutUSerCase.call();
    result.fold(
      ifLeft: (failure) {
        if (failure.statusCode == 401) {
          return emit(
            UnAuthorized(message: failure.message, isTokenExpired: true),
          );
        } else if (failure.statusCode == 403) {
          return emit(
            UnAuthorized(message: failure.message, isAccountInactive: true),
          );
        }
      },
      ifRight: (message) => emit(UnAuthorized(message: message)),
    );
  }
}
