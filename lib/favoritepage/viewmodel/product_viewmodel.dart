import 'package:flutter/material.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:furniture_ui/homepage/models/sample_product.dart';


class ProductViewModel extends ChangeNotifier {
  // Location
  String _location = "Your City";
  String get location => _location;

  void updateLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }


  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
  _selectedCategory = category;
  notifyListeners();
  }

  // Products
  final List<ProductModel> _allProducts = sampleProducts;
  List<ProductModel> get productList {
    if (_selectedCategory.isEmpty) return _allProducts;
    return _allProducts
        .where((product) => product.category == _selectedCategory)
        .toList();
  }
  //liked
  final List<ProductModel> _likedProducts = [];
  List<ProductModel> get likedProducts => _likedProducts;

  void toggleLike(ProductModel product) {
    if (_likedProducts.contains(product)) {
      _likedProducts.remove(product);
    } else {
      _likedProducts.add(product);
    }
    notifyListeners();
  }

  bool isLiked(ProductModel product) {
    return _likedProducts.contains(product);
  }
  // Wishlist
  final List<ProductModel> _wishlist = [];
  List<ProductModel> get wishlist => _wishlist;


  void toggleWishlist(ProductModel product) {
    if (_wishlist.contains(product)) {
      _wishlist.remove(product);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(ProductModel product) {
    return _wishlist.contains(product);
  }
}
