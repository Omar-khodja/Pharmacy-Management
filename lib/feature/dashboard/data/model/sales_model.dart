import 'package:pharmacy_management/feature/dashboard/domain/entities/sales_data.dart';

class SalesModel extends SalesData {
  const SalesModel({
    required super.count,
    required super.total,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      count: json['count'] as int,
      total: (json['total'] as num).toDouble(),
    );
  }

} 