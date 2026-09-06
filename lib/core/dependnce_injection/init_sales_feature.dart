import 'package:get_it/get_it.dart';
import 'package:pharmacy_management/feature/Sales/data/data_source.dart/sales_datasource.dart';
import 'package:pharmacy_management/feature/Sales/data/repo/sales_repo_impl.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/get_sale_details_usecase.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/get_sales_usecase.dart';

void initSalesFeature(GetIt sl) {
  sl.registerSingleton(SalesDatasource(apiClient: sl()));
  sl.registerSingleton(SalesRepoImpl(datasource: sl<SalesDatasource>(), tokenStorage: sl()));
  sl.registerSingleton(GetSaleDetailsUsecase(repo: sl<SalesRepoImpl>()));
  sl.registerSingleton(GetSalesUsecase(repo: sl<SalesRepoImpl>()));
}
