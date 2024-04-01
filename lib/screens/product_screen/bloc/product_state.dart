import '../../../model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final String? category;

  ProductLoaded(this.products, {this.category});
}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductsFiltered extends ProductState {
  final List<Product> products;

  ProductsFiltered(this.products);
}
