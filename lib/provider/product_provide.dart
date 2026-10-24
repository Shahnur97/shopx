import 'package:flutter/foundation.dart';
import 'package:shopx/data/product_api.dart';
import 'package:shopx/data/product_class.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = true;
  String? _error;

  List<String> get categories {
    final unique = _products.map((p) => p.category).toSet();
    return ['All', ...unique];
  }

  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadProducts() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final product = await fetchProducts();
      _products = product;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _error = 'Could not get any product, please try again';
      notifyListeners();
    }
  }
}
