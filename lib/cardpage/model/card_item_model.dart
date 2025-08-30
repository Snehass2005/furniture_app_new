class CartItemModel {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}
