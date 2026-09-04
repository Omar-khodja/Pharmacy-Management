import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/add_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/delete_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/details_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/edite_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/search_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_event.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/medicien_mangment_bloc/medicien_mangment_bloc_state.dart';

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
    on<AddMedicineEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await addUsecase.call(event.medicine);
      result.fold(
        ifLeft: (failure) => emit(MedicienErrorState(failure.message)),
        ifRight: (message) => emit(SuccessfulMessageState(message)),
      );
    });

    on<EditMedicineEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await editeUsecase.call(event.medicine);
      result.fold(
        ifLeft: (failure) => emit(MedicienErrorState(failure.message)),
        ifRight: (message) => emit(SuccessfulMessageState(message)),
      );
    });

    on<DeleteMedicineEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await deleteUsecase.call(event.id);
      result.fold(
        ifLeft: (failure) => emit(MedicienErrorState(failure.message)),
        ifRight: (message) => emit(SuccessfulMessageState(message)),
      );
    });
    on<SearchMedicinesEvent>((event, emit) async {
      emit(const MedicienLoadingState());
      final result = await searchUsecase.call(event.query);
      result.fold(
        ifLeft: (failure) => emit(MedicienErrorState(failure.message)),
        ifRight: (medicien) => emit(MedicienLoadedState(medicien)),
      );
    });
  }
}
