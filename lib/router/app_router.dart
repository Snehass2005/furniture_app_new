import 'package:flutter/material.dart';
import 'package:furniture_ui/profilepage/view/language_preferences_page.dart';
import 'package:go_router/go_router.dart';
import 'package:furniture_ui/homepage/view/homepage.dart';
import 'package:furniture_ui/favoritepage/view/favorite_page.dart';
import '../Product_Details/view/product_details.dart'; // ensure correct path
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:furniture_ui/main_scaffold.dart';

import '../profilepage/view/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScaffold(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailsPage(product: product);
      },
    ),
    GoRoute(
      path: '/profile', // 👈 New route for profile page
      builder: (context, state) => const LanguagePreferencesPage(),
    ),
  ],
);

