import 'package:flutter/material.dart';
import 'package:shopx/provider/cart_provider.dart';
import 'package:shopx/provider/favorite_provider.dart';
import 'package:shopx/provider/product_provide.dart';
import 'package:shopx/screens/splash_screen.dart';
import 'package:shopx/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()..loadProducts())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      //Light theme configuration...........
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.light(primary: Colors.orange),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey.shade200,
        cardColor: Colors.white,
      ),

      //Dark theme configuration............
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.dark(primary: Colors.orange),
        appBarTheme: const AppBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF2C2C2C),
      ),

      home: SplashScreen(),
    );
  }
}


// Testing use only.......................
// void main() async {
//   try {
//     final products = await fetchProducts();
//     print('Count: ${products.length}');
//     print('Count: ${products.first.id}');
//     print('Count: ${products.first.title}');
//     print('Count: ${products.first.category}');
//     print('Count: ${products.first.price}');
//   } catch (e) {
//     print('Error $e');
//   }
// }