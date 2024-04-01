import 'package:basic_ecommerce_app/screens/product_detail_screen/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:basic_ecommerce_app/model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavoriteStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFavoriteStatus();
  }

  void loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool newFavoriteStatus = prefs.getBool('favorite_${widget.product!.id}') ?? false;
    if (isFavorite != newFavoriteStatus) {
      setState(() {
        isFavorite = newFavoriteStatus;
      });
    }
  }

  void toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteProductIds') ?? [];
    bool newFavoriteStatus = !isFavorite;

    if (newFavoriteStatus) {
      favoriteIds.add(widget.product!.id.toString());
    } else {
      favoriteIds.remove(widget.product!.id.toString());
    }
    await prefs.setStringList('favoriteProductIds', favoriteIds);

    await prefs.setBool('favorite_${widget.product!.id}', newFavoriteStatus);
    loadFavoriteStatus();
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
          'Product Details',
          style: GoogleFonts.playfairDisplay().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Image.network(widget.product!.imageUrl, fit: BoxFit.cover)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          )),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                        onPressed: toggleFavorite,
                      ),
                    ],
                  ),
                  buildDetailRichText('Name', widget.product!.name),
                  buildDetailRichText('Price', '\$${widget.product!.price}'),
                  buildDetailRichText('Category', widget.product!.category),
                  buildDetailRichText('Brand', widget.product!.brandName),
                  buildDetailRichText(
                      'Rating', widget.product!.rating.toString()),
                  buildDetailRichText('Stock', widget.product!.stock.toString()),
                  buildDetailRichText(
                      'Description', widget.product!.description),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding:const  EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GridTile(
                    child: Image.network(
                      widget.product!.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                childCount: widget.product!.images.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
