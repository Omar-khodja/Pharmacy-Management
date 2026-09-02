import 'package:dart_either/src/dart_either.dart';
import 'package:pharmacy_management/core/error/api_error_handler.dart';
import 'package:pharmacy_management/core/error/exceptions.dart';
import 'package:pharmacy_management/core/error/failure.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/dashboard/data/data_source.dart/base_dashboard_datasource.dart';
import 'package:pharmacy_management/feature/dashboard/domain/entities/dashboard_data.dart';
import 'package:pharmacy_management/feature/dashboard/domain/repo/base_dashboard_repo.dart';

class DashboardRepoImpl extends BaseDashboardRepo {
  final BaseDashboardDatasource datasource;
  final TokenStorage tokenStorage;
  final ApiErrorHandler apiErrorHandler;

  DashboardRepoImpl({
    required this.datasource,
    required this.tokenStorage,
    required this.apiErrorHandler,
  });
  @override
  Future<Either<AppFailure, DashboardData>> getDashboardData() async {
    try {
      final token = await tokenStorage.getToken();
      if (token == null) {
        return Left(LocalStorageFailure("No token found"));
      }
      final dashboardData = await datasource.getDashboardData(
        token,
      );
      return Right(dashboardData);
    } on RemoteException catch (e) {
      final String message = apiErrorHandler.handleError(e.message);
      return Left(RemoteFailure(message));
    }on AppDioException catch (e) {
      return Left(DioFailure(e.message));
    }
  }
}
