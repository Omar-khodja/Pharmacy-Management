import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/core/dependnce_injection/init_auth_feature.dart';
import 'package:pharmacy_management/core/dependnce_injection/init_dashboard_feature.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => TokenStorage());
  sl.registerLazySingleton(() => ApiClient(dio: sl<Dio>(),onUnauthorized: () => sl<AuthCubit>().forcedLogOUt() ));
  sl.registerLazySingleton(() => AuthCubit(loginUsecase: sl(), longOutUsecase: sl(), forcedlogOutUSerCase: sl()),);
  initAuthFeature(sl);
  initDashboardFeature(sl);
}
