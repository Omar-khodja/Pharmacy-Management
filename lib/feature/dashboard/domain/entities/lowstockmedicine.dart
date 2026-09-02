import 'package:equatable/equatable.dart';

class Lowstockmedicine extends Equatable {
  final int id;
  final String name;
  final int quantity;

  const Lowstockmedicine({
    required this.id,
    required this.name,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, name, quantity];
}