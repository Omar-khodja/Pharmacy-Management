import 'package:pharmacy_management/feature/dashboard/domain/entities/today_sales.dart';

class TodaSalesModel extends TodaySales {
  const TodaSalesModel({
    required super.count,
    required super.total,
  });

  factory TodaSalesModel.fromJson(Map<String, dynamic> json) {
    return TodaSalesModel(
      count: json['count'] as int,
      total: (json['total'] as num).toDouble(),
    );
  }

} 