import 'package:flutter/cupertino.dart';
import 'package:pharmacy_management/core/model/category_model.dart';
import 'package:pharmacy_management/core/model/medicien_model.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/data/data_source.dart/base_medicien_m_datasource.dart';

class MedicienMDatasource implements BaseMedicienMDatasource {
  new({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<String> addMedicien(MedicienModel medicien, String token) async {
    try {
      final respons = await apiClient.post(
        "/medicines",
        token,
        medicien.toAddJson(),
      );
      debugPrint("////////////////// add ${respons.data.toString()}");
      return "Medicien Added Successfully";
    } catch (e) {
      debugPrint("////////////////// add ${e.toString()}");

      rethrow;
    }
  }

  @override
  Future<String> deletMedicien(int id, String token) async {
    try {
      final respons = await apiClient.delete("/medicines/$id", token);
      debugPrint(respons.data.toString());
      return "Medicien Deleted Successfully";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> editeMedicien(
    MedicienModel medicien,
    String token,
    int id,
  ) async {
    try {
      final respons = await apiClient.put(
        "/medicines/$id",
        token,
        medicien.toEditJson(),
      );
      debugPrint(respons.data.toString());
      return "Medicien Updated Successfully";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MedicienModel> getDetails(String id, String token) async {
    try {
      final respons = await apiClient.get("/medicines/$id", token);
      debugPrint(respons.data.toString());
      final data = respons.data['data'] as Map<String, dynamic>;
      return MedicienModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MedicienModel>> search(String query, String token) async {
    try {
      final respons = await apiClient.get(
        "/medicines?q=$query",
        token,
      );
      debugPrint(
        "/////////////////////////////////// search ${respons.data.toString()}",
      );
      final List data = respons.data['data'] as List;
      return data.map((json) => MedicienModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("/////////////////////////////////// search ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategory(String token) async {
    try {
      final respons = await apiClient.get("/categories", token);
      debugPrint(
        "/////////////////////////////////// category ${respons.data["data"]}",
      );
      final List data = respons.data['data'] as List;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint(
        "/////////////////////////////////// category ${e.toString()}",
      );
      rethrow;
    }
  }
}
