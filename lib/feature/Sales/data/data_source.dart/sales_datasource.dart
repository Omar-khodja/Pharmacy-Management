import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Sales/data/data_source.dart/baes_sales_datasource.dart';
import 'package:pharmacy_management/feature/Sales/data/model/sale_model.dart';

class SalesDatasource extends BaesSalesDatasource {
  new({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<SaleModel> fetchSaleDetails(int id, String token) async {
    try {
      final response = await apiClient.get("/sales/$id", token);
      final json = response.data["data"];
      return SaleModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SaleModel>> fetchSales(String token) async {
    try {
      final response = await apiClient.get("/sales", token);
      final List<dynamic> list = response.data["data"] as List<dynamic>;
      return list.map((json) => SaleModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> postSale(List<Map<String, dynamic>> items) {
    // TODO: implement postSale
    throw UnimplementedError();
  }
}
