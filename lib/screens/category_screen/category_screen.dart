import 'package:basic_ecommerce_app/screens/category_screen/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../model/category_model.dart';
import '../../repository/categories_repository.dart';
import '../product_screen/product_screen.dart';
import 'bloc/category_bloc.dart';
import 'bloc/category_event.dart';
import 'bloc/category_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(
        categoryRepository: CategoryRepository(httpClient: http.Client()),
      )..add(FetchCategoriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Categories',
            style: GoogleFonts.playfairDisplay().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoadedState) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = state.categories[index];
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                                  category: category.name,
                                )),
                      );
                    },
                  );
                },
              );
            } else if (state is CategoryErrorState) {
              return const Center(child: Text('Failed to load categories'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
