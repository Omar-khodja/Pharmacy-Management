import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/storage/tokenstorage.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/data/data_source.dart/medicien_m_datasource.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/data/repo/medicien_m_repo_impl.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/add_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/delete_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/details_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/edite_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/get_category_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/search_usecase.dart';

void initMedicienMangmentFeature(GetIt sl) {
  sl.registerLazySingleton(
    () => MedicienMDatasource(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton(
    () => MedicienMRepoImpl(
      datasource: sl<MedicienMDatasource>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );
  sl.registerLazySingleton(() => GetCategoryUseCase(sl<MedicienMRepoImpl>()));
  sl.registerLazySingleton(() => AddUsecase(sl<MedicienMRepoImpl>()));
  sl.registerLazySingleton(() => DeleteUsecase(sl<MedicienMRepoImpl>()));
  sl.registerLazySingleton(() => EditeUsecase(sl<MedicienMRepoImpl>()));
  sl.registerLazySingleton(() => SearchUsecase(sl<MedicienMRepoImpl>()));
  sl.registerLazySingleton(() => DetailsUsecase(sl<MedicienMRepoImpl>()));
}
