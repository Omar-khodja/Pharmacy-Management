import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  new({required this.medicienId, required this.quantity});
  final int medicienId;
  final int quantity;
  @override
  List<Object?> get props => [medicienId,quantity];
}
