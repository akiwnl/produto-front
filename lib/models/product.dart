class Product {
  final int id;
  final String description;
  final double price;
  final int quantity;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.description,
    required this.price,
    required this.quantity,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      quantity: json['quantity'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'price': price,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
