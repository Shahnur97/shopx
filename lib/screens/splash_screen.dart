import 'package:flutter/material.dart';
import 'package:shopx/screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  
  const SplashScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MainPage(
                onThemeToggle: widget.onThemeToggle,
                isDarkMode: widget.isDarkMode,
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsetsGeometry.all(20)),
            //App icon........
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 60,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),

            //App name......
            const Text(
              'shopX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 8),

            //Tagline.......
            const Text(
              'Shop Smarter. Live Better.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 40),

            //Loading indicator.....
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
