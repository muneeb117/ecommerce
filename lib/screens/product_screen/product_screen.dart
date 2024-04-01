import 'package:basic_ecommerce_app/screens/product_screen/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product_model.dart';
import '../../repository/product_repository.dart';
import '../product_detail_screen/product_details_screen.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final String? category;
  ProductsScreen({super.key, this.category}) {
    print("Selected category: $category");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(repository: ProductRepository(httpClient: http.Client()))
            ..add(category != null
                ? FetchProductsByCategory(category!)
                : FetchProducts()),
      child: Builder(
        builder: (newContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                category?.isNotEmpty == true ? category! : 'Products',
                style: GoogleFonts.playfairDisplay().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a product',
                        contentPadding: EdgeInsets.only(top: 10.h),
                        prefixIcon:const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (query) {
                        BlocProvider.of<ProductBloc>(newContext)
                            .add(SearchProducts(query));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ProductList(_searchController),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final TextEditingController searchController;

  const ProductList(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded || state is ProductsFiltered) {
          List<Product> products = state is ProductsFiltered
              ? state.products
              : (state as ProductLoaded).products;
          final filteredProducts = products
              .where((product) => product.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                          product: filteredProducts[index]),
                    ),
                  );
                },
                child: ProductCard(product: filteredProducts[index]),
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Please wait'));
      },
    );
  }
}
