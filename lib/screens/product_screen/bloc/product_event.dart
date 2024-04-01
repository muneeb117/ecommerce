abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}
class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}
class FetchProductsByCategory extends ProductEvent {
  final String category;

  FetchProductsByCategory(this.category);

}

