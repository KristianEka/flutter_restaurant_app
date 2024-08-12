import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: "Restaurant List",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SettingsPage(),
  ];
}
