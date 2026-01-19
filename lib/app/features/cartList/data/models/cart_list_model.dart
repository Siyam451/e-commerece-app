class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String? image;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      productId: json['product']['_id'],
      title: json['product']['title'],
      price: (json['product']['current_price'] ?? 0).toDouble(),
      quantity: json['quantity'],
      image: (json['product']['photos'] as List).isNotEmpty
          ? json['product']['photos'][0]
          : null,
    );
  }
}
