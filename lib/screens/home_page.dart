import 'package:flutter/material.dart';
import 'package:shopx/provider/product_provide.dart';
import 'package:shopx/widgets/product_card.dart';
// import 'package:shopx/data/products.dart';
// import 'package:shopx/data/product_class.dart';
import 'package:shopx/screens/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shopx/provider/cart_provider.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onCartTap;

  const HomePage({super.key, required this.onCartTap});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchText = '';

  final TextEditingController searchController = TextEditingController();

  // final categories = [
  //   'All',
  //   'Electronics',
  //   'Clothing',
  //   'Food',
  //   'Gaming',
  //   'Beauty',
  // ];


  @override
  Widget build(BuildContext context) {
  final categories = context.watch<ProductProvider>().categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'shopX',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.orange,
          ),
        ),

        actions: [
          Consumer<CartProvider>(
            builder: ((context, value, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () => widget.onCartTap(),
                  ),
                  if (value.itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${value.cartItems.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            //Search bar.............
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: TextField(
                controller: searchController,
                onChanged: (value) =>
                    setState(() => searchText = value), //needs to understand
                decoration: InputDecoration(
                  hintText: 'Search products....',
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            //category chips........
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            //Gridview producths............
            Expanded(child: _productBody()),
          ],
        ),
      ),
    );
  }

  Widget _productBody() {
    //filter products by category AND search
    // final filtered = products.where((p) {
    //   final matchesCategory =
    //       selectedCategory == 'All' || p['category'] == selectedCategory;
    //   final matchesSearch = p['title']!.toLowerCase().contains(
    //     searchText.toLowerCase(),
    //   );
    //   return matchesCategory && matchesSearch;
    // }).toList();

    final productProvider = context.watch<ProductProvider>();
    if (productProvider.loading) {
      return Center(child: CircularProgressIndicator());
    }
    if (productProvider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product could not laod, please try again.'),
            ElevatedButton(
              onPressed: context.read<ProductProvider>().loadProducts,
              child: Text('Try again'),
            ),
          ],
        ),
      );
    }
    if (productProvider.products.isEmpty) {
      return Center(child: Text('No products match your search'));
    }

    final filtered = productProvider.products.where((p) {
      final matchesCategory =
          selectedCategory == 'All' || p.category == selectedCategory;
      final matchesSearch = p.title.toLowerCase().contains(
        searchText.toLowerCase(),
      );
      return matchesSearch && matchesCategory;
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final product = filtered[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(product: product),
                ),
              );
            },

            //product card is here.............
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}
