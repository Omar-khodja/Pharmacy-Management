import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/create_sale_usecase.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit_state.dart';

class NewSaleCubit extends Cubit<NewSaleCubitState> {
  final CreateSaleUsecase createSaleUsecase;
  new({required this.createSaleUsecase}) : super(InitNewSaleState());

  Future<void> addToBasket(Medicine medicien) async {
    final currenstate = state.medicine;
    emit(NewSaleData(medicines: currenstate));
  }

  Future<void> removeFromBasket(Medicine medicine) async {
    final currentMedicines = List<Medicine>.from(state.medicine)
      ..removeWhere((m) => m.id == medicine.id);

    emit(NewSaleData(medicines: currentMedicines));
  }

  Future<void> clearBasket() async {
    emit(InitNewSaleState());
  }
}
