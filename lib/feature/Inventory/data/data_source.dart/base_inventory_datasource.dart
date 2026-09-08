import 'package:pharmacy_management/feature/Inventory/data/model/inventory_alaret_model.dart';


abstract class BaseInventoryDatasource {
  Future<String> updateQuantity(int id, int quantity, String token);
  Future<InventoryAlaretModel> getAlaret(String token);
}
