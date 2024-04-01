import 'package:equatable/equatable.dart';

import '../../../model/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Category> categories;

  CategoryLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CategoriesFilteredState extends CategoryState {
  final List<Category> filteredCategories;

  CategoriesFilteredState({required this.filteredCategories});

  @override
  List<Object> get props => [filteredCategories];
}
