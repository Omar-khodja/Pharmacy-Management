import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/usecase/forced_logout_usecae.dart';
import 'package:pharmacy_management/core/usecase/longout_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/get_currenuser_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final LoginUsecase _loginUsecase;
  final LongOutUsecase _longOutUsecase;
  final ForcedlogOutUSerCase _forcedlogOutUSerCase;
  final GetCurrenuserUsecase _getCurrenuserUsecase;

  AuthCubit({
    required this._loginUsecase,
    required this._longOutUsecase,
    required this._forcedlogOutUSerCase,
    required this._getCurrenuserUsecase
  }) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    final result = await _loginUsecase.call(email, password);
    result.fold(
      ifLeft: (failure) =>
          emit(UnAuthorized(message: failure.message, isValidationError: true)),
      ifRight: (authstate) => emit(Authorized(authstate)),
    );
  }

  Future<void> getCurrentUser() async {
    emit(const AuthLoading());
    final result = await _getCurrenuserUsecase.call();
    result.fold(
      ifLeft: (failure) =>
          emit(UnAuthorized(message: failure.message, isValidationError: true)),
      ifRight: (authstate) => emit(Authorized(authstate)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await _longOutUsecase.call();
    result.fold(
      ifLeft: (failure) =>
          emit(UnAuthorized(message: failure.message, isTokenExpired: true)),
      ifRight: (message) =>
          emit(UnAuthorized(message: message, isTokenExpired: true)),
    );
  }

  Future<void> forcedLogOUt() async {
    emit(const AuthLoading());
    final result = await _forcedlogOutUSerCase.call();
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
