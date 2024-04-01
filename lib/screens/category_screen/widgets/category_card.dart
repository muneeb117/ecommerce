import 'package:flutter/material.dart';
import '../../../model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({Key? key, required this.category, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset(
                  category.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                ),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0, // Adjust font size as necessary
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
