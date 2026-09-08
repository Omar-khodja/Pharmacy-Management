import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/feature/Inventory/data/data_source.dart/inventory_datasource.dart';
import 'package:pharmacy_management/feature/Inventory/data/repo/inventory_repo_impl.dart';
import 'package:pharmacy_management/feature/Inventory/domain/usecase/get_alaret_usecase.dart';
import 'package:pharmacy_management/feature/Inventory/domain/usecase/updatequantity_usecase.dart';

void initInventoryFeature(GetIt sl) {
  sl.registerLazySingleton(() => InventoryDatasource(apiClient: sl()));
  sl.registerLazySingleton(
    () => InventoryRepoImpl(
      datasource: sl<InventoryDatasource>(),
      tokenStorage: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAlaretUsecase(repo: sl<InventoryRepoImpl>()),
  );
  sl.registerLazySingleton(
    () => UpdatequantityUsecase(repo: sl<InventoryRepoImpl>()),
  );
}
