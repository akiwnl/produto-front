class Product {
  final String description;
  final double price;
  final int quantity;

  Product({
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      description: json['description'],
      price: (json['price'] is String)
          ? double.parse(json['price'])
          : json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}
