class Order {
  int id;
  String orderId;
  String store;
  String storeImage;
  String storeBranch;
  String? storeLongitude;
  String? storeLatitude;
  String clientName;
  String clientPhone;
  String orderStatus;
  String orderStatusAr;
  int amountPaid;
  String amount;
  String? longitude;
  String? latitude;
  String whatUpMassage;
  String whatUpMassageAr;

  Order({
    required this.id,
    required this.orderId,
    required this.store,
    required this.storeImage,
    required this.storeBranch,
    this.storeLongitude,
    this.storeLatitude,
    required this.clientName,
    required this.clientPhone,
    required this.orderStatus,
    required this.orderStatusAr,
    required this.amountPaid,
    required this.amount,
    this.longitude,
    this.latitude,
    required this.whatUpMassage,
    required this.whatUpMassageAr,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? '',
      store: json['store'] ?? '',
      storeImage: json['store_image'] ?? '',
      storeBranch: json['store_branch'] ?? '',
      storeLongitude: json['store_longitude'] ?? '',
      storeLatitude: json['store_latitude'] ?? '',
      clientName: json['client_name'] ?? '',
      clientPhone: json['client_phone'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderStatusAr: json['order_status_ar'] ?? '',
      amountPaid: json['amount_paid'] ?? '',
      amount: json['amount'] ?? '',
      longitude: json['longitude'] ??'',
      latitude: json['latitude'] ?? '',
      whatUpMassage: json['what_up_massage'] ?? '',
      whatUpMassageAr: json['what_up_massage_ar'] ?? '',
    );
  }
}
