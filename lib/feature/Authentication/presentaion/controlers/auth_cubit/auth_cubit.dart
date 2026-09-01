import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';
import 'package:pharmacy_management/feature/Authentication/presentaion/controlers/auth_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final LoginUsecase loginUsecase;

  AuthCubit(this.loginUsecase) : super(AuthInitial());
  
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUsecase(email, password);
    result.fold(
      ifLeft: (failure) => emit(AuthFailure(failure.message)),
      ifRight: (authstate) => emit(AuthSuccess(authstate)),
    );
  }
  Future<void> logout() async {
    emit(AuthLoggedOut());
  }
}
