import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';
import 'package:pharmacy_management/feature/dashboard/domain/repo/base_dashboard_repo.dart';

class GetDashBoardDataUseCase {
  GetDashBoardDataUseCase({required this.repo});
  final BaseDashboardRepo repo;


  Future<Either<AppFailure, DashboardData>> call() async {
    return await repo.getDashboardData();
  }
}