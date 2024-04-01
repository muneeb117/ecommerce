import 'package:basic_ecommerce_app/screens/account_screen/account_screen.dart';
import 'package:basic_ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:basic_ecommerce_app/screens/faviourte_screen/favorite_screen.dart';
import 'package:basic_ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget buildPage(index) {
  List<Widget> _widgets = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];
  return _widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "Products",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child:Icon(Icons.shopping_bag_outlined),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: Icon(Icons.shopping_bag),
      )),
  BottomNavigationBarItem(

      label: "Categories",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: Icon(Icons.category_outlined),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child:Icon(Icons.category)
      )),
  BottomNavigationBarItem(
      label: "Favorites",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child:Icon(Icons.favorite_border),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child:  Icon(Icons.favorite),
      )),

  BottomNavigationBarItem(
      label: "Profile",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: Icon(Icons.person_outline),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: Icon(Icons.person),
      )),

];
