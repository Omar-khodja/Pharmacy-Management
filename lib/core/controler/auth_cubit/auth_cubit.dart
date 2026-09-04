import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/usecase/longout_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final LoginUsecase loginUsecase;
  final LongOutUsecase longOutUsecase;

  AuthCubit({required this.loginUsecase, required this.longOutUsecase})
    : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    final result = await loginUsecase.call(email, password);
    result.fold(
      ifLeft: (failure) => emit(UnAuthorized(message: failure.message)),
      ifRight: (authstate) => emit(Authorized(authstate)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await longOutUsecase.call();
    result.fold(
      ifLeft: (failure) {
        if (failure.message == "401") {
          return emit(
            const UnAuthorized(
              message: "Not logged in or token expired. Please log in again.",
              statusCode: 401,
            ),
          );
        }
        return emit(UnAuthorized(message: failure.message));
      },
      ifRight: (message) => emit(UnAuthorized(message: message)),
    );
  }
}
