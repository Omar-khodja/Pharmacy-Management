import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';

sealed class MedicienMangmentBlocState extends Equatable{
  const MedicienMangmentBlocState();
    @override
  List<Object?> get props => [];
}
class MedicieninitState extends MedicienMangmentBlocState {
  const MedicieninitState();
}


class MedicienLoadingState extends MedicienMangmentBlocState {
  const MedicienLoadingState();
}

class MedicienLoadedState extends MedicienMangmentBlocState {
  final List<Medicine> medicines;
  final String? message;
  final String? errorMessage;
  const MedicienLoadedState({required this.medicines,this.message,this.errorMessage});
    @override
  List<Object?> get props => [message,medicines,errorMessage];
}




