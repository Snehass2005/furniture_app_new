import 'package:flutter/material.dart';
import 'package:furniture_ui/cardpage/model/card_item_model.dart';
import 'package:furniture_ui/cardpage/viewmodel/card_viewmodel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:furniture_ui/app_translations.dart';
import 'package:furniture_ui/Product_details/widgets/image_zoom.dart';
import 'package:furniture_ui/Product_details/widgets/color_selector.dart';
import 'package:furniture_ui/homepage/view_model/product_viewmodel.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:furniture_ui/homepage/models/sample_product.dart';


class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title:  Text('product_details'.tr),
        leading: const BackButton(),
        actions: [
          Consumer<ProductViewModel>(
            builder: (context, productVM, _) {
              final isLiked = productVM.isLiked(product);
              return IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  productVM.toggleLike(product);
                },
              );
            },
          ),
        ],
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Main Image
    Center(
    child: Image.asset(
      (product.imageList != null && product.imageList!.isNotEmpty)
          ? product.imageList![selectedImageIndex]
          : product.imageUrl,
      height: 220,
    fit: BoxFit.contain,
    ),
    ),
    const SizedBox(height: 12),

    // Thumbnails
    SizedBox(
    height: 60,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
      itemCount: product.imageList?.length ?? 0,

      itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageZoomPage(
              imagePath: product.imageList![index],
            ),
          ),
        );
      },

      child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
    border: Border.all(
    color: selectedImageIndex == index
    ? Colors.teal
        : Colors.grey.shade300,
    width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
    ),
    child: Image.asset(
      (product.imageList != null && product.imageList!.isNotEmpty)
          ? product.imageList![index]
          : product.imageUrl,
    width: 50,
    fit: BoxFit.cover,
    ),
    ),
    );
    },
    ),
    ),
    const SizedBox(height: 16),

    // Category and Rating
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(product.category.tr, style: TextStyle(color: Colors.grey)),
      Row(
    children: [
    const Icon(Icons.star, color: Colors.amber, size: 18),
    const SizedBox(width: 4),
    Text(
    product.rating.toString(),
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    ],
    ),
    ],
    ),
    const SizedBox(height: 8),

    // Title
    Text(
    product.title.tr,
    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 12),

    // Description
    Text("product_details".tr,
    style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 4),
    Text(
    "product_description".tr,
    style: TextStyle(color: Colors.grey),
    ),
    const SizedBox(height: 10),

      const SizedBox(height: 20),
      Text(
        "product_information".tr,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildInfoRow("brand".tr, "urban_living".tr),
            _buildInfoRow("material".tr, "solid_wood_velvet".tr),
            _buildInfoRow("dimensions".tr,"dimensions_value".tr),
            _buildInfoRow("weight".tr, "weight_value".tr),
            _buildInfoRow("warranty".tr,"warranty_value".tr),
            _buildInfoRow("assembly".tr,"assembly_value".tr),
            _buildInfoRow("delivery".tr,  "delivery_value".tr),
          ],
        ),
      ),

      // Color Selection
      Text("select_color".tr),
      const SizedBox(height: 8),
      Row(
        children: product.colors.map((color) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 24),


      // Price and Add to Cart Button
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Price\n₹${product.price.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<CartViewModel>(context, listen: false).addItem(
                CartItemModel(
                  id: product.id.toString(), // Make sure product has a unique id
                  title: product.title,
                  imageUrl: product.imageUrl,
                  price: product.price,
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.title} added to cart')),
              );
            },
            icon: const Icon(Icons.shopping_bag),
            label: Text("add_to_cart".tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

        ],
      ),
    ],
    ),
    ),
    );
  }
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: Text(
              value.tr,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

