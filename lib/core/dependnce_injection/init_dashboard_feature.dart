import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/core/error/api_error_handler.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/dashboard/data/data_source.dart/dashboard_remote_datasource.dart';
import 'package:pharmacy_management/feature/dashboard/data/repo/dashboardoard_repo_impl.dart';
import 'package:pharmacy_management/feature/dashboard/domain/usecase/get_dashboarddata_usecase.dart';

void initDashboardFeature(GetIt sl) {
  sl.registerLazySingleton(
    () => DashboardRemoteDatasource(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton(
    () => DashboardRepoImpl(
      datasource: sl<DashboardRemoteDatasource>(),
      tokenStorage: sl<TokenStorage>(),
      apiErrorHandler: sl<ApiErrorHandler>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetDashBoardDataUseCase(repo: sl<DashboardRepoImpl>()),
  );
}
