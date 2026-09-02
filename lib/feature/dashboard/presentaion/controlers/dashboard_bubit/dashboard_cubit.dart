import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/dashboard/domain/usecase/get_dashboarddata_usecase.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit_state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit({required this.getDashBoardDataUseCase})
    : super(const DashboardLoadingState());
  final GetDashBoardDataUseCase getDashBoardDataUseCase;

  Future<void> getDashboardData() async {
    emit(const DashboardLoadingState());
    final result = await getDashBoardDataUseCase();
    result.fold(
      ifLeft:  (failure) => emit(DashboardFailureState(failure.message)),
      ifRight: (dashboardData) => emit(DashboardLoadedState(dashboardData)),
    );
  }
}
