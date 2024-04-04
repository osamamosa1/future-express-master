class OrderStatus {
  final int id;
  final String title;
  final String titleAr;
  final int isOtp;
  final int sendImage;
  final int restaurantAppear;
  final int storeAppear;
  final int orderNumber;
  final String description;

  OrderStatus({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.isOtp,
    required this.sendImage,
    required this.restaurantAppear,
    required this.storeAppear,
    required this.orderNumber,
    required this.description,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'] as int,
      title: json['title'] as String,
      titleAr: json['title_ar'] as String,
      isOtp: json['is_otp'] as int,
      sendImage: json['send_image'] as int,
      restaurantAppear: json['restaurant_appear'] as int,
      storeAppear: json['store_appear'] as int,
      orderNumber: json['order_number'] as int,
      description: json['description'] as String? ?? '',
    );
  }
}
