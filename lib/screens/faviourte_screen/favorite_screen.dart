import 'package:basic_ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_ecommerce_app/model/product_model.dart';
import 'package:basic_ecommerce_app/repository/product_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Product> favoriteProducts = [];
  final ProductRepository repository =
      ProductRepository(httpClient: http.Client());

  @override
  void initState() {
    super.initState();
    _loadFavoriteProducts();
  }

  Future<void> _loadFavoriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteProductIds') ?? [];

    List<Product> allProducts = await repository.fetchProducts();
    setState(() {
      favoriteProducts = allProducts
          .where((product) => favoriteIds.contains(product.id.toString()))
          .toList();
    });
  }

  void _removeFromFavorites(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteProductIds') ?? [];

    setState(() {
      favoriteProducts.remove(product);
    });

    favoriteIds.remove(product.id.toString());
    await prefs.setStringList('favoriteProductIds', favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Favourites',
          style: GoogleFonts.playfairDisplay().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 0,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: AppColors.strokeColor,
                  )),
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(product.imageUrl),
                      radius: 20.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                product.rating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              RatingBar.builder(
                                unratedColor: AppColors.strokeColor,
                                initialRating: product.rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20.w,
                                ignoreGestures: true,
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => _removeFromFavorites(product),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
