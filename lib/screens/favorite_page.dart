import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/data/product_class.dart';
import 'package:shopx/provider/favorite_provider.dart';
import 'package:shopx/provider/product_provide.dart';
import 'package:shopx/widgets/product_card.dart';
import 'package:shopx/screens/detail_page.dart';

class FavoritePage extends StatelessWidget {
  final List<Product> product;
  const FavoritePage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final allProducts = context.watch<ProductProvider>().products;
    // Filter products that are favorited
    final favoriteProducts = allProducts
        .where((p) => favoriteProvider.favorites.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favoriteProducts.isEmpty
          ? _emptyFavorites()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
    );
  }

  Widget _emptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 15),
          const Text(
            'No favorites yet!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart on any product to save it.',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
