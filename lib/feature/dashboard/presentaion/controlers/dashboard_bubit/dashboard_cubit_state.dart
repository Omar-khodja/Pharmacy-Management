import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';

sealed class DashboardCubitState extends Equatable{
  const DashboardCubitState();
    @override
  List<Object?> get props => [];
}
class DashboardLoadingState extends DashboardCubitState {
  const DashboardLoadingState();
}
class DashboardLoadedState extends DashboardCubitState {
  final DashboardData dashboardData;
  const DashboardLoadedState(this.dashboardData);
    @override
  List<Object?> get props => [dashboardData];
}

class DashboardFailureState extends DashboardCubitState {
  final String message;
  const DashboardFailureState(this.message);
    @override
  List<Object?> get props => [message];

}

