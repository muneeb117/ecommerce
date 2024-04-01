import 'package:basic_ecommerce_app/repository/product_repository.dart';
import 'package:basic_ecommerce_app/screens/account_screen/account_screen.dart';
import 'package:basic_ecommerce_app/screens/application/application_page.dart';
import 'package:basic_ecommerce_app/screens/application/bloc/app_bloc.dart';
import 'package:basic_ecommerce_app/screens/category_screen/bloc/category_bloc.dart';
import 'package:basic_ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:basic_ecommerce_app/screens/faviourte_screen/favorite_screen.dart';
import 'package:basic_ecommerce_app/screens/product_detail_screen/product_details_screen.dart';
import 'package:basic_ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/product_screen/bloc/product_bloc.dart';
import '../screens/splash_screen/splash_screen.dart';
import 'name.dart';

class AppPage {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.initial,
      page: const SplashScreen(),
    ),
    PageEntity(
      route: AppRoutes.application,
      page: const ApplicationPage(),
      bloc: BlocProvider(
        create: (_) => AppBlocs(),
      ),
    ),
    PageEntity(
      route: AppRoutes.products,
      page: ProductsScreen(),
      bloc: BlocProvider(create: (_) => ProductBloc()),
    ),

    PageEntity(
      route: AppRoutes.categories,
      page: const CategoriesScreen(),
      bloc: BlocProvider(
        create: (_) => CategoryBloc(),
      ),
    ),

    PageEntity(
      route: AppRoutes.favorites,
      page: FavoritesScreen(),
    ),
    PageEntity(
      route: AppRoutes.profile,
      page: const AccountScreen(),
    ),
  ];

  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var bloc in routes) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc as BlocProvider);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes.where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        if (result.first.route == AppRoutes.initial) {
          return MaterialPageRoute(
              builder: (_) => const SplashScreen(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const SplashScreen(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, this.bloc});
}
