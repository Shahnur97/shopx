import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map<String, String> product;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const DetailPage({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                //product image..........
                Hero(
                  tag: 'product-${widget.product['name']}',
                  child: Image.network(
                    widget.product['image']!,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                //back button..........
                Positioned(
                  top: 40,
                  left: 15,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),

                //favorite button..........
                Positioned(
                  top: 40,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      widget.onFavoriteTap();
                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //product details............
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //category tag and rating row............
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.product['category']!,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Spacer(),

                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),

                      Text(
                        widget.product['rating']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  //product name..........
                  Text(
                    widget.product['name']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  //product price.........
                  Text(
                    '\$${widget.product['price']}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),

                  //description heading.........
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  //Description..........
                  Text(
                    widget.product['description']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //quantity selector placeholder.....
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //decrease button........
                      GestureDetector(
                        onTap: () {
                          if (quantity >= 1) {
                            setState(() => quantity--);
                          }
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.remove, size: 18),
                        ),
                      ),

                      //quantity display..........
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$quantity',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //increase button............
                      GestureDetector(
                        onTap: () => setState(() => quantity++),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  //cart button................
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${widget.product['name']} added to cart!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.orange,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            'Add to Cart - \$${(int.parse(widget.product['price']!))}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}