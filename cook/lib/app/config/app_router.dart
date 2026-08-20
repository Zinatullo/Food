import 'package:cook/features/category/pages/categoryPage.dart';
import 'package:cook/features/foodDetail/pages/FoodDetail.dart';
import 'package:cook/features/home/pages/home_page.dart';
import 'package:cook/features/location/ui/pages/select_location_page.dart';
import 'package:cook/features/onboarding/pages/onboarding_page.dart';
import 'package:cook/features/restaurantDetail/pages/RestaurantDetail.dart';
import 'package:cook/features/search/pages/SearchPage.dart';
import 'package:cook/features/splash/presentation/pages/splash_page.dart';
import 'package:cook/services/food_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/location',
      builder: (context, state) => const SelectLocationPage(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        final cartCount = (state.extra as int?) ?? 0;

        return SearchPage(cartCount: cartCount);
      },
    ),
GoRoute(
  path: '/category',
  builder: (BuildContext context, GoRouterState state) {
    final categoryName = state.uri.queryParameters['name'] ?? 'All';
    final foodItem = state.extra as FoodItem?;

    return CategoryPage(
      categoryName: categoryName,
      item: foodItem,
    );
  },
),
GoRoute(
  path: '/rest',
  builder: (BuildContext context, GoRouterState state) {
    final restaurantName = state.uri.queryParameters['name'] ?? 'All'; // добавили 's'
    final restaurantItems = state.extra as FoodItem?; // добавили '?'

    return Restaurantdetail(
      restaurantName: restaurantName,
      item: restaurantItems,
    );
  },
),
GoRoute(
  path: '/food',
  builder: (BuildContext context, GoRouterState state) {
    final foodtName = state.uri.queryParameters['name'] ?? 'All'; // добавили 's'
    final foodtItems = state.extra as FoodItem; // добавили '?'

    return FoodDetail(
      foodName: foodtName,
      item: foodtItems,
    );
  },
),
// GoRoute(
//   path: '/rest',
//   builder: (BuildContext context, GoRouterState state) {
//     final restaurantName = state.uri.queryParameters['name'] ?? 'All';
//     final restaurantItems = state.extra as FoodItem?;

//     return Restaurantdetail(
//       restaurantName: restaurantName,
//       item: restaurantItems,
//     );
//   },
// ),
  ],
);
