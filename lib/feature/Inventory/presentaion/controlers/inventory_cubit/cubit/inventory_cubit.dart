import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_management/core/network/network_manager.dart';
import 'package:pharmacy_management/feature/Inventory/domain/entities/inventory_alaret.dart';
import 'package:pharmacy_management/feature/Inventory/domain/usecase/get_alaret_usecase.dart';
import 'package:pharmacy_management/feature/Inventory/domain/usecase/updatequantity_usecase.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit({
    required this._getAlaretUsecase,
    required this._updatequantityUsecase,
  }) : super(const InventoryLoding()){
     NetworkManager.networkRestoredController.stream.listen((_) {
      getAlaret(); // retry when internet is back
    });
  }
  final GetAlaretUsecase _getAlaretUsecase;
  final UpdatequantityUsecase _updatequantityUsecase;

  Future<void> getAlaret() async {
    emit(const InventoryLoding());

    final response = await _getAlaretUsecase.call();

    response.fold(
      ifLeft: (error) {
        emit(InventoryError(error.message));
      },
      ifRight: (value) => emit(Inventorydata(alaret: value)),
    );
  }

  Future<void> updateQuntity(int id, int quntity) async {
    final currentstate = (state as Inventorydata).alaret;

    emit(const InventoryLoding());
    final response = await _updatequantityUsecase.call(id, quntity);

    response.fold(
      ifLeft: (error) {
        Fluttertoast.showToast(msg: error.message, backgroundColor: Colors.red);
      },
      ifRight: (value) {
        Fluttertoast.showToast(msg: value);
        final updatedLowStock = currentstate.lowStock
            .map(
              (item) => item.id == id ? item.copyWith(quantity: quntity) : item,
            )
            .where((element) => element.quantity <= element.minStockLevel!)
            .toList();

        final updatedExpired = currentstate.expired
            .map(
              (item) => item.id == id ? item.copyWith(quantity: quntity) : item,
            )
            .toList();

        final updatedExpiredSoon = currentstate.expiredSoon
            .map(
              (item) => item.id == id ? item.copyWith(quantity: quntity) : item,
            )
            .toList();

        final updatedstate = currentstate.copyWith(
          expired: updatedExpired,
          expiredSoon: updatedExpiredSoon,
          lowStock: updatedLowStock,
        );

        emit(Inventorydata(alaret: updatedstate));
      },
    );
  }
}
