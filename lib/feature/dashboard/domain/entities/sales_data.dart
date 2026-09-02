import 'package:equatable/equatable.dart';

class SalesData extends Equatable {
  final int count;
  final double total;

 

  const SalesData({
    required this.count,
    required this.total,
  });

  @override
  List<Object?> get props => [
        count,
        total,
      ];
}