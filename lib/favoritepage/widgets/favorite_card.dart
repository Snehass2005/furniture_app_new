import 'package:flutter/material.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:get/get.dart';


class FavoriteCard extends StatelessWidget {
  final ProductModel product;

  const FavoriteCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: product.imageUrl.startsWith('http')
                ? Image.network(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 80),
            )
                : Image.asset(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${product.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
