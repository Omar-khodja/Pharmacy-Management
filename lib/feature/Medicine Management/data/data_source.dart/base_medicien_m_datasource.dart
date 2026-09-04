import 'package:pharmacy_management/core/model/medicien_model.dart';

abstract class BaseMedicienMDatasource {
  Future<List<MedicienModel>> search(String query,String token);
  Future<MedicienModel> getDetails(String id, String token);
  Future<String> addMedicien(MedicienModel medicien, String token);
  Future<String> editeMedicien(MedicienModel medicien, String token ,int id);
  Future<String> deletMedicien(int id, String token);
}
