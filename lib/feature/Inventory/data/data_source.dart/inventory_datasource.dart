import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Inventory/data/data_source.dart/base_inventory_datasource.dart';
import 'package:pharmacy_management/feature/Inventory/data/model/inventory_alaret_model.dart';

class InventoryDatasource implements BaseInventoryDatasource {
  new({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<InventoryAlaretModel> getAlaret(String token) async {
    try {
      final response = await apiClient.get("/inventory/alerts", token);
      return InventoryAlaretModel.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateQuantity(int id, int quantity, String token) async {
    try {
      await apiClient.post("/inventory/stock", token, {
        "medicine_id": id,
        "quantity": quantity,
      });

      return "Quantity Updated Successfuly";
    } catch (e) {
      rethrow;
    }
  }
}
