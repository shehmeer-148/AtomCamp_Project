class CartShoeItemEntities{
  final int id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartShoeItemEntities({required this.id, required this.name, required this.price, required this.image, required this.quantity});

  CartShoeItemEntities copyWith({
    int? id,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartShoeItemEntities(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}