import 'package:pharmacy_management/core/entities/category.dart';

sealed class CategoryCubitState {
  CategoryCubitState();
}

class CategoryinitState extends CategoryCubitState {
  final List<Category> category;
  CategoryinitState() : category = const [];
}

class CategoryLoadedState extends CategoryCubitState {
  final List<Category> category;
  CategoryLoadedState(this.category);
}

class CategoryErrorState extends CategoryCubitState {
  final String message;
  CategoryErrorState(this.message);
}
