import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';

sealed class DashboardCubitState {
  const DashboardCubitState();
}
class DashboardLoadingState extends DashboardCubitState {
  const DashboardLoadingState();
}
class DashboardLoadedState extends DashboardCubitState {
  final DashboardData dashboardData;
  const DashboardLoadedState(this.dashboardData);
}

class DashboardFailureState extends DashboardCubitState {
  final String message;
  const DashboardFailureState(this.message);

}

