import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/core/entities/medicien.dart';
import 'package:pharmacy_management/core/network/network_manager.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/add_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/delete_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/details_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/edite_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/search_usecase.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc_state.dart';

class MedicienMangmentBloc
    extends Bloc<MedicienMangmentBlocEvent, MedicienMangmentBlocState> {
  final EditeUsecase editeUsecase;
  final DeleteUsecase deleteUsecase;
  final AddUsecase addUsecase;
  final DetailsUsecase detailsUsecase;
  final SearchUsecase searchUsecase;
  new({
    required this.addUsecase,
    required this.deleteUsecase,
    required this.detailsUsecase,
    required this.editeUsecase,
    required this.searchUsecase,
  }) : super(const MedicieninitState()) {
    NetworkManager.networkRestoredController.stream.listen((_) {
      add(const SearchMedicinesEvent(""));
    });

    on<AddMedicineEvent>((event, emit) async {
      final result = await addUsecase.call(event.medicine);
      final currentMedicines = state is MedicienLoadedState
          ? (state as MedicienLoadedState).medicines
          : <Medicine>[];
      result.fold(
        ifLeft: (failure) => emit(
          MedicienLoadedState(
            errorMessage: failure.message,
            medicines: currentMedicines,
          ),
        ),
        ifRight: (message) => emit(
          MedicienLoadedState(medicines: currentMedicines, message: message),
        ),
      );
    });

    on<EditMedicineEvent>((event, emit) async {
      final result = await editeUsecase.call(event.medicine);
      final currentMedicines = state is MedicienLoadedState
          ? (state as MedicienLoadedState).medicines
          : <Medicine>[];

      result.fold(
        ifLeft: (failure) => emit(
          MedicienLoadedState(
            errorMessage: failure.message,
            medicines: currentMedicines,
          ),
        ),
        ifRight: (message) {
          final updatedList = currentMedicines.map((item) {
            return item.id == event.medicine.id
                ? item.copyWith(
                    name: event.medicine.name,
                    expiryDate: event.medicine.expiryDate,
                    category: event.medicine.category,
                    price: event.medicine.price,
                    categoryId: event.medicine.categoryId,
                  )
                : item;
          }).toList();
          emit(MedicienLoadedState(medicines: updatedList, message: message));
        },
      );
    });

    on<DeleteMedicineEvent>((event, emit) async {
      final result = await deleteUsecase.call(event.id);

      final currentMedicines = state is MedicienLoadedState
          ? (state as MedicienLoadedState).medicines
          : <Medicine>[];

      currentMedicines.removeWhere((element) => element.id == event.id);
      result.fold(
        ifLeft: (error) => emit(
          MedicienLoadedState(
            medicines: currentMedicines,
            errorMessage: error.message,
          ),
        ),
        ifRight: (value) {
          final updatedMedicines = currentMedicines
              .where((m) => m.id != event.id)
              .toList();

          emit(
            MedicienLoadedState(medicines: updatedMedicines, message: value),
          );
        },
      );
    });
    on<SearchMedicinesEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await searchUsecase.call(event.query);
      result.fold(
        ifLeft: (failure) => emit(
          MedicienLoadedState(medicines: [], errorMessage: failure.message),
        ),
        ifRight: (medicien) => emit(MedicienLoadedState(medicines: medicien)),
      );
    });
    on<GetMedicineDetailsEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await detailsUsecase.call(int.parse(event.id));
      result.fold(
        ifLeft: (failure) => debugPrint(
          "///////////////////////////////////////${failure.toString()}",
        ),
        ifRight: (medicien) => debugPrint(
          "///////////////////////////////////////${medicien.toString()}",
        ),
      );
    });
  }
}
