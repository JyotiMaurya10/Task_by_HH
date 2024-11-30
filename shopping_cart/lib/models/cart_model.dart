class CartItem {
  final int id;
  final String title;
  final String? brand;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    required this.brand,
    required this.discountPercentage,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
        id: id,
        title: title,
        thumbnail: thumbnail,
        price: price,
        quantity: quantity ?? this.quantity,
        brand: brand,
        discountPercentage: discountPercentage);
  }
}
