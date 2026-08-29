import 'package:flutter/material.dart';
import 'package:shopx/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //track currnet theme........
  bool isDarkMode = false;

  //toggle between light and dark...........
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

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

      home: SplashScreen(
        onThemeToggle: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
