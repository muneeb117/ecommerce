import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/categories_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository? categoryRepository;

  CategoryBloc({this.categoryRepository}) : super(CategoryInitialState()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try {
        final categories = await categoryRepository!.fetchCategories();
        emit(CategoryLoadedState(categories: categories));
      } catch (e) {
        emit(CategoryErrorState(message: e.toString()));
      }
    });

    on<SearchCategoriesEvent>((event, emit) async {
      if (state is CategoryLoadedState) {
        final loadedState = state as CategoryLoadedState;
        final filteredCategories = loadedState.categories.where(
                (category) => category.name.toLowerCase().contains(event.query.toLowerCase())
        ).toList();
        emit(CategoriesFilteredState(filteredCategories: filteredCategories));
      }
    });
  }
}
