import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/category_model.dart';
class CategoryRepository {
  final http.Client httpClient;

  CategoryRepository({required this.httpClient});

  Future<List<Category>> fetchCategories() async {
    final response = await httpClient.get(Uri.parse('https://dummyjson.com/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((categoryName) => Category(
        name: categoryName as String,
        imageUrl: Category.getImageUrlForCategory(categoryName),
      )).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
