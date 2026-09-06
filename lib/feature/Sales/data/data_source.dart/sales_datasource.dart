import 'package:flutter/cupertino.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Sales/data/data_source.dart/baes_sales_datasource.dart';
import 'package:pharmacy_management/feature/Sales/data/model/invoice_model.dart';
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
  Future<String> postSale(List<InvoiceModel> items, String token) async {
    try {
      final response = await apiClient.post("/sales", token, {
        "items": items.map((item) => item.toJson()).toList(),
      });
      debugPrint("////////////create sale ${response.data.toString()} ");
      return "Invoice Submited Successfully";
    } catch (e) {
      rethrow;
    }
  }
}
