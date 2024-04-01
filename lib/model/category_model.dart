class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});

  static String getImageUrlForCategory(String categoryName) {
    Map<String, String> categoryImages = {
      "smartphones": "assets/categories/smartphones.jpg",
      "laptops": "assets/categories/laptops.jpg",
      "fragrances": "assets/categories/fragrances.jpg",
      "groceries": "assets/categories/grocieries.jpg",
      "home-decoration": "assets/categories/home_decoration.jpg",
      "furniture": "assets/categories/skincare.jpg",
      "skincare": "assets/categories/furniture.jpg",
    };
    return categoryImages[categoryName] ?? "assets/categories/fragrances.jpg";
  }
}
