class Item {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
  });

  factory Item.fromMap(String id, Map<String, dynamic> data) {
    return Item(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
    };
  }
}
