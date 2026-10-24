import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopx/data/product_class.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products?limit=20'),
  ).timeout(const Duration(seconds: 10));
  if (response.statusCode != 200) {
    throw Exception('No product found. ${response.statusCode}');
  }
  final data = jsonDecode(response.body);
  final productData = (data['products'] as List).map(
    (item) => Product.fromJson(item)
  ).toList();

  return productData;
}
