import 'dart:convert';

import 'package:http/http.dart'as http;

import '../model/product_model.dart';
class ProductRepository {
  final http.Client httpClient;

  ProductRepository({required this.httpClient});

  Future<List<Product>> fetchProducts() async {
    final response = await httpClient.get(Uri.parse('https://dummyjson.com/products?limit=100'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List).map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching products');
    }
  }
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await httpClient.get(Uri.parse('https://dummyjson.com/products/category/$category'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'] as List<dynamic>;
      return productsJson.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Error fetching products by category');
    }
  }

}
