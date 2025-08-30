import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:furniture_ui/favoritepage/widgets/favorite_card.dart';
import 'package:furniture_ui/homepage/view_model/product_viewmodel.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);
    final likedProducts = productVM.likedProducts;

    print("Liked products count: ${likedProducts.length}");
    return Scaffold(
      appBar: AppBar(title: Text("favorites".tr)),
      body: likedProducts.isEmpty
          ?  Center(child: Text("no_liked_products".tr))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          print("Favorite product title: ${likedProducts[index].title}");
          print("Favorite image: ${likedProducts[index].imageUrl}");
          return FavoriteCard(
            product: likedProducts[index],
          );
        },
      ),
    );
  }
}
