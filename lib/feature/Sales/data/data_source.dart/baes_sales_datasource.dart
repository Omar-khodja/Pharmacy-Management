// data/datasources/sales_datasource.dart
import 'package:pharmacy_management/feature/Sales/data/model/invoice_model.dart';
import 'package:pharmacy_management/feature/Sales/data/model/sale_model.dart';

abstract class BaesSalesDatasource {
  /// Fetch sales list from API
  Future<List<SaleModel>> fetchSales(String token);

  /// Fetch single sale details
  Future<SaleModel> fetchSaleDetails(int id, String token);

  /// Post new sale to API
  Future<String> postSale(List<InvoiceModel> items,String token);
}
