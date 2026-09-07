import 'package:equatable/equatable.dart';

class TodaySales extends Equatable {
  final int count;
  final double total;

 

  const TodaySales({
    required this.count,
    required this.total,
  });

  @override
  List<Object?> get props => [
        count,
        total,
      ];
}