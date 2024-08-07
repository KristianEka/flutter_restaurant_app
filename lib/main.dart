import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_review_page.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: onPrimaryColor,
              secondary: secondaryColor,
            ),
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        RestaurantSearchPage.routeName: (context) =>
            const RestaurantSearchPage(),
        RestaurantReviewPage.routeName: (context) => RestaurantReviewPage(
            restaurantDetail:
                ModalRoute.of(context)?.settings.arguments as RestaurantDetail),
      },
      navigatorKey: navigatorKey,
    );
  }
}
