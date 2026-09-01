

import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Authentication/data/data_source.dart/auth_remote_datasource.dart';
import 'package:pharmacy_management/feature/Authentication/data/repo/auth_repo_impl.dart';
import 'package:pharmacy_management/feature/Authentication/domain/usecase/login_usecase.dart';

final sl = GetIt.instance;

void initAuthFeature() {
  sl.registerLazySingleton(() => AuthRemoteDatasource(sl<ApiClient>()));
  sl.registerLazySingleton(()=> AuthRepoImpl(datasource: sl<AuthRemoteDatasource>(), tokenStorage: sl<TokenStorage>()));
  sl.registerLazySingleton(()=> LoginUsecase(sl<AuthRepoImpl>()));
}