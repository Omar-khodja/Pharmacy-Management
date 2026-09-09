import 'package:pharmacy_management/core/entities/medicine.dart';

sealed class NewSaleCubitState {
  final List<Medicine> medicine;

  const new(this.medicine);
}

final class InitNewSaleState extends NewSaleCubitState {
  new() : super([]);
}

final class NewSaleData extends NewSaleCubitState {
  final String? errorMessage;
  
  new({required List<Medicine> medicines, this.errorMessage})
    : super(medicines);
}
