import 'package:flutter/foundation.dart';
import 'package:shopx/data/product_class.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;
  double get totalPrice => _totalPrice();

  double _totalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  void addToCart(Product product, int quantity) {
    final index = _cartItems.indexWhere(
      (item) => item.product.title == product.title,
    );
    if (index != -1) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      _cartItems.removeWhere((item) => item.product.id == productId);
    } else {
      final index = _cartItems.indexWhere(
        (item) => item.product.id == productId,
      );
      if (index != -1) {
        _cartItems[index].quantity = newQuantity;
      }
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }
}
