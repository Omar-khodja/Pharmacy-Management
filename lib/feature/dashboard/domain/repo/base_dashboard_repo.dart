import 'package:dart_either/dart_either.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';

abstract class BaseDashboardRepo {
  Future<Either<AppFailure, DashboardData>> getDashboardData();
}