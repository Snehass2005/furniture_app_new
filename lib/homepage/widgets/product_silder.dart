import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:furniture_ui/homepage/view_model/product_viewmodel.dart';

class ProductSlider extends StatelessWidget {
  const ProductSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = context.watch<ProductViewModel>().productList;

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
     children: [
    const SizedBox(height: 10),
    if (product.imageList!.isNotEmpty)
    Hero(
    tag: product.imageList![0],
    child: Image.asset(
    product.imageList![0],
    height: 100,
    fit: BoxFit.contain,
    ),
    )
    else
    const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
    const SizedBox(height: 10),
    Text(
    product.title,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    Text(
    "₹${product.price.toStringAsFixed(0)}",
    style: const TextStyle(color: Colors.grey),
    ),
    ],
    ),
    );
  }
}
