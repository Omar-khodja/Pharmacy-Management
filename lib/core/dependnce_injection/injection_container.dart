import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/core/dependnce_injection/init_auth_feature.dart';
import 'package:pharmacy_management/core/error/api_error_handler.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(()=> ApiErrorHandler()); 
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => TokenStorage());
  sl.registerLazySingleton(() => ApiClient(dio: sl<Dio>()));
  initAuthFeature();
}
