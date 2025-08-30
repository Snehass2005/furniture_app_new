import 'package:flutter/foundation.dart';
import '../../homepage/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
