import 'package:pharmacy_management/core/model/category_model.dart';
import 'package:pharmacy_management/core/model/medicine_model.dart';

abstract class BaseMedicienMDatasource {
  Future<List<MedicineModel>> search(String query, String token);
  Future<MedicineModel> getDetails(String id, String token);
  Future<String> addMedicien(MedicineModel medicien, String token);
  Future<String> editeMedicien(MedicineModel medicien, String token, int id);
  Future<String> deletMedicien(int id, String token);
  Future<List<CategoryModel>> getCategory(String token);

}
