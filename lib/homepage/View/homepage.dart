import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:furniture_ui/favoritepage/view/favorite_page.dart';
import 'package:furniture_ui/homepage/widgets/product_card.dart';
import 'package:furniture_ui/homepage/widgets/category_title.dart';
import 'package:furniture_ui/homepage/widgets/banner_slider.dart';
import 'package:furniture_ui/homepage/widgets/flash_sale_timer.dart';
import 'package:furniture_ui/homepage/view_model/product_viewmodel.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:furniture_ui/Homepage/models/sample_product.dart';

Route _createRouteToFavorites() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const FavoritePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0); // From right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'all';
  bool isEditingLocation = false;

  final TextEditingController _locationController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Widget _buildChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
          selected:
   selectedFilter == value,
      onSelected: (bool selected) {
        setState(() {
          selectedFilter = value;
        });
      },
      selectedColor: Colors.teal,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: selectedFilter == value ? Colors.white : Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);
    final products = productVM.productList;

    List<ProductModel> filteredProducts = products
        .whereType<ProductModel>() // removes nulls
        .where((product) {
      if (selectedFilter == 'all') return true;
      if (selectedFilter == 'newest') return product.isNew;
      if (selectedFilter == 'popular') return product.isPopular;
      if (selectedFilter == 'bedroom') return product.category.toLowerCase() == 'bedroom';
      return true;
    }).toList();



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.black),
            const SizedBox(width: 4),
            isEditingLocation
                ? SizedBox(
              width: 180,
              child: TextField(
                controller: _locationController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your location',
                ),
                style: const TextStyle(color: Colors.black),
                onSubmitted: (value) {
                  productVM.updateLocation(value);
                  setState(() {
                    isEditingLocation = false;
                  });
                },
              ),
            )
            :GestureDetector(
              onTap: () {
                setState(() {
                  isEditingLocation = true;
                  _locationController.text = productVM.location;
                });
              },
              child: Text(
                productVM.location.isEmpty
                    ? 'your_city'.tr
                    : productVM.location,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Furniture'.tr,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Banner
            const BannerSlider(),
            const SizedBox(height: 20),

            // Category title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All".tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Category tiles
           const SizedBox(height: 12),
          // Category tiles
                    Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           CategoryTile(icon: Icons.weekend, label: "Sofa".tr, onTap: () => productVM.setCategory("sofa")),
                          CategoryTile(icon: Icons.chair, label: "Chair".tr, onTap: () => productVM.setCategory("chair")),
                           CategoryTile(icon: Icons.lightbulb_outline, label: "Lamp".tr, onTap: () => productVM.setCategory("lamp")),
                           CategoryTile(icon: Icons.kitchen, label: "Cupboard".tr, onTap: () => productVM.setCategory("cupboard")),
                         ],
                    ),
            const SizedBox(height: 20),

            // Flash Sale
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("Flash Sale".tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                CountdownTimerWidget(),
              ],
            ),
            const SizedBox(height: 12),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip("all".tr, "all"),
                  const SizedBox(width: 8),
                  _buildChip("newest".tr, "newest"),
                  const SizedBox(width: 8),
                  _buildChip("popular".tr, "popular"),
                  const SizedBox(width: 8),
                  _buildChip("bedroom".tr, "bedroom"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    print("${'Navigating to details for:'.tr} ${product.title}");
                    context.push('/details', extra: product);
                  },
                  child: ProductCard(product: product),
                );

              },
            ),
          ],
        ),
      ),
    );
  }


}


