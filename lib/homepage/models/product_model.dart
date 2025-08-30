import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String title;
  final String imageUrl;
  final List<String>? imageList;
  final double price;
  final String category;
  final double rating;
  final List<Color> colors;
  final bool isNew;
  final bool isPopular;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.imageList,
    required this.price,
    required this.category,
    this.rating = 4.5,
    this.colors = const [Colors.black, Colors.blue],
    this.isNew = false,
    this.isPopular = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductModel &&
              runtimeType == other.runtimeType &&
  title == other.title &&
  imageUrl == other.imageUrl &&
  price == other.price;

  @override
  int get hashCode =>
      title.hashCode ^ imageUrl.hashCode ^ price.hashCode ^ category.hashCode;
}
