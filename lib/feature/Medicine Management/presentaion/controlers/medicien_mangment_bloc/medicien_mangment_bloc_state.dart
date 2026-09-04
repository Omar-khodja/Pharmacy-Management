import 'package:pharmacy_management/core/entities/medicien.dart';

sealed class MedicienMangmentBlocState {
  const MedicienMangmentBlocState();
}

class MedicienLoading extends MedicienMangmentBlocState {
  const MedicienLoading();
}

class MedicienLoaded extends MedicienMangmentBlocState {
  final List<Medicine> medicines;
  const MedicienLoaded(this.medicines);
}
class SuccessfulMessage extends MedicienMangmentBlocState {
  final String message;
  const SuccessfulMessage(this.message);
}


class MedicienError extends MedicienMangmentBlocState {
  final String errorMessage;
  const MedicienError(this.errorMessage);
}
