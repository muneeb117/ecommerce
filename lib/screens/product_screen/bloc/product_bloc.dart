import 'package:basic_ecommerce_app/screens/product_screen/bloc/product_event.dart';
import 'package:basic_ecommerce_app/screens/product_screen/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product_model.dart';
import '../../../repository/product_repository.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository? repository;
  List<Product> _fullProductList = [];

  ProductBloc({ this.repository}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        _fullProductList = await repository!.fetchProducts();
        emit(ProductLoaded(_fullProductList));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<FetchProductsByCategory>((event, emit) async {
      emit(ProductLoading());
      try {
        final productList = await repository!.fetchProductsByCategory(event.category);
        emit(ProductLoaded(productList, category: event.category)); // Include category here
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<SearchProducts>((event, emit) {
      if (event.query.isEmpty) {
        final currentState = state;
        if (currentState is ProductLoaded && currentState.category != null) {
          add(FetchProductsByCategory(currentState.category!));
        } else {
          add(FetchProducts());
        }
      } else {
        final currentState = state;
        if (currentState is ProductLoaded) {
          final filteredList = currentState.products.where((product) {
            return product.name.toLowerCase().contains(event.query.toLowerCase());
          }).toList();
          emit(ProductLoaded(filteredList, category: currentState.category));
        }
      }
    });


  }
}
