import 'package:equatable/equatable.dart';

class MedicineSale  extends Equatable {
  final int id;
  final String name;
  final String unit;

 const  MedicineSale({required this.id, required this.name, required this.unit});



  @override
  List<Object?> get props => [id,name,unit];
}
