import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/domain/usecase/get_category_usecase.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/controlers/category_cubit/category_cubit_state.dart';

class CategoryCubit extends Cubit<CategoryCubitState> {
  final GetCategoryUseCase getCategoryUseCase;

  CategoryCubit({required this.getCategoryUseCase})
    : super(CategoryinitState());

  Future<void> getCategory() async {
    final response = await getCategoryUseCase();
    response.fold(
      ifLeft: (errormessage) => emit(CategoryErrorState(errormessage.message)),
      ifRight: (value) => emit(CategoryLoadedState(value)),
    );
  }
}
  