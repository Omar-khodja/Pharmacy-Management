import 'package:pharmacy_management/core/entities/medicien.dart';

sealed class MedicienMangmentBlocEvent {
  const MedicienMangmentBlocEvent();
}

class SearchMedicinesEvent extends MedicienMangmentBlocEvent {
  final String query;
  const SearchMedicinesEvent(this.query);
}

class GetMedicineDetailsEvent extends MedicienMangmentBlocEvent {
  final String id;
  const GetMedicineDetailsEvent(this.id);
}

class AddMedicineEvent extends MedicienMangmentBlocEvent {
  final Medicine medicine;
  const AddMedicineEvent(this.medicine);
}

class EditMedicineEvent extends MedicienMangmentBlocEvent {
  final Medicine medicine;
  const EditMedicineEvent(this.medicine);
}


class DeleteMedicineEvent extends MedicienMangmentBlocEvent {
  final int id;
  const DeleteMedicineEvent(this.id);
}
