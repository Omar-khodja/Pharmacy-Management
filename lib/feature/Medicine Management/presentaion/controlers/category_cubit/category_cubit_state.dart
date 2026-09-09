import 'package:equatable/equatable.dart';
import 'package:pharmacy_management/core/entities/category.dart';

sealed class CategoryCubitState extends Equatable{
  const CategoryCubitState();
    @override
  List<Object?> get props => [];
}

class CategoryinitState extends CategoryCubitState {
  final List<Category> category;
 const  CategoryinitState() : category = const [];
    @override
  List<Object?> get props => [category];
}

class CategoryLoadedState extends CategoryCubitState {
  final List<Category> category;
 const CategoryLoadedState(this.category);
    @override
  List<Object?> get props => [category];
}

class CategoryErrorState extends CategoryCubitState {
  final String message;
const  CategoryErrorState(this.message);
    @override
  List<Object?> get props => [message];
}
