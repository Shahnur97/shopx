import 'package:flutter/material.dart';
import 'package:shopx/screens/home_page.dart';
import 'package:shopx/screens/favorite_page.dart';
import 'package:shopx/screens/cart_page.dart';
import 'package:shopx/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MainPage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isDarkMode != widget.isDarkMode) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(),
      FavoritePage(),
      CartPage(),
      ProfilePage(
        onThemeToggle: widget.onThemeToggle,
        isDarkMode: widget.isDarkMode,
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
