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
      id: json['id'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ??
          0.0, // Convertendo corretamente para double
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
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
