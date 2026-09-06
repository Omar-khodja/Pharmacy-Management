import 'package:equatable/equatable.dart';

class Cashier extends Equatable {
  final int id;
  final String name;

  const Cashier({required this.id, required this.name});

  @override
  List<Object?> get props => [id ,name];



}
