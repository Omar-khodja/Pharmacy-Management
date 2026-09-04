import 'package:pharmacy_management/core/entities/medicien.dart';

sealed class MedicienMangmentBlocState {
  const MedicienMangmentBlocState();
}
class MedicieninitState extends MedicienMangmentBlocState {
  const MedicieninitState();
}


class MedicienLoadingState extends MedicienMangmentBlocState {
  const MedicienLoadingState();
}

class MedicienLoadedState extends MedicienMangmentBlocState {
  final List<Medicine> medicines;
  const MedicienLoadedState(this.medicines);
}
class SuccessfulMessageState extends MedicienMangmentBlocState {
  final String message;
  const SuccessfulMessageState(this.message);
}


class MedicienErrorState extends MedicienMangmentBlocState {
  final String errorMessage;
  const MedicienErrorState(this.errorMessage);
}
