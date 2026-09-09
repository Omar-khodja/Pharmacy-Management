import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/entities/medicine.dart';
import 'package:pharmacy_management/feature/Sales/domain/entities/invoice.dart';
import 'package:pharmacy_management/feature/Sales/domain/usecase/create_sale_usecase.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/new_sale_cubit.dart/new_sale_cubit_state.dart';

class NewSaleCubit extends Cubit<NewSaleCubitState> {
  final CreateSaleUsecase createSaleUsecase;
  new({required this.createSaleUsecase}) : super(InitNewSaleState());
  Future<void> saveInvoice() async {
    final currentState = state.medicine;
    final List<Invoice> invoiceList = currentState
        .map((m) => Invoice(medicienId: m.id!, quantity: m.orederedQuantity))
        .toList();
 
    final response = await createSaleUsecase.call(invoiceList);
    response.fold(
      ifLeft: (value) => emit(
        NewSaleData(medicines: currentState, errorMessage: value.message),
      ),
      ifRight: (value) {
        Fluttertoast.showToast(msg: value);
        emit(InitNewSaleState());
      },
    );
  }

  Future<void> addToBasket(Medicine medicine) async {
    if (medicine.quantity > 0) {
      final currentState = List<Medicine>.from(state.medicine);
      final exists = currentState.any((m) => m.id == medicine.id);

      if (!exists) {
        currentState.add(medicine.copyWith(orederedQuantity: 1));
        emit(NewSaleData(medicines: currentState));
      } else {
        emit(
          NewSaleData(
            medicines: currentState,
            errorMessage: "Item alredy exists in cart!",
          ),
        );
      }
    }
  }

  Future<void> incrementQuantity(int id) async {
    debugPrint("increment");
    final currentState = List<Medicine>.from(state.medicine);
    final index = currentState.indexWhere((m) => m.id == id);

    if (index != -1) {
      if (currentState[index].orederedQuantity < currentState[index].quantity) {
        final updated = currentState[index].copyWith(
          orederedQuantity: currentState[index].orederedQuantity + 1,
        );
        currentState[index] = updated;
        emit(NewSaleData(medicines: currentState));
      }
    }
  }

  Future<void> decrementQuantity(int id) async {
    final currentState = List<Medicine>.from(state.medicine);
    final index = currentState.indexWhere((m) => m.id == id);

    if (index != -1) {
      if (currentState[index].orederedQuantity > 1) {
        final currentQty = currentState[index].orederedQuantity;

        final updated = currentState[index].copyWith(
          orederedQuantity: currentQty - 1,
        );
        currentState[index] = updated;
        emit(NewSaleData(medicines: currentState));
      } else {
        emit(
          NewSaleData(
            medicines: currentState,
            errorMessage: "Quntity can't be less then 1",
          ),
        );
      }
    }
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
