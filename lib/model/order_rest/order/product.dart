class Product {
  int? id;
  String? productName;
  String? size;
  int number;
  double price;
  String createdAt;
  String updatedAt;
  int orderId;
  dynamic deletedAt;

  Product({
    required this.id,
    required this.productName,
    required this.size,
    required this.number,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      size: json['size'] ?? '',
      number: json['number'] ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      orderId: json['order_id'] ?? 0,
      deletedAt: json['deleted_at'],
    );
  }
}
