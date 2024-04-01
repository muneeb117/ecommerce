import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final int id;
  final String name;
  final String brandName;
  final String imageUrl;
  final double rating;
  final int price;
  final String category;
  final int stock;
  final String description;
  final List<String> images;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.brandName,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.category,
    required this.stock,
    required this.description,
    required this.images,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      name: json['title'] as String? ?? 'Unknown',
      brandName: json['brand'] as String? ?? 'Unknown',
      imageUrl: json['thumbnail'] as String? ?? 'https://via.placeholder.com/150',
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
      price: json['price'] as int? ?? 0,
      category: json['category'] as String? ?? 'Unknown',
      stock: json['stock'] as int? ?? 0,
      description: json['description'] as String? ?? 'No description provided.',
      images: List<String>.from(json['images'] as List? ?? []),
      isFavorite: false,
    );
  }

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_$id', isFavorite);
  }

  static Future<bool> getFavoriteStatus(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('favorite_$id') ?? false;
  }
}
