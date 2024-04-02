class ScanOrder {
  final int id;
  final String orderId;
  final String trackingNumber;
  final String store;
  final String storeImage;
  final String storePhone;
  final String storeEmail;
  final String clientName;
  final String clientPhone;
  final String clientEmail;
  final String clientCity;
  final String clientCityAr;
  final String clientAddress;
  final String addressDetails;
  final String amount;
  final String orderStatus;
  final String orderStatusAr;
  final String whatsAppMessage;
  final String whatsAppMessageAr;

  ScanOrder({
    required this.id,
    required this.orderId,
    required this.trackingNumber,
    required this.store,
    required this.storeImage,
    required this.storePhone,
    required this.storeEmail,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.clientCity,
    required this.clientCityAr,
    required this.clientAddress,
    required this.addressDetails,
    required this.amount,
    required this.orderStatus,
    required this.orderStatusAr,
    required this.whatsAppMessage,
    required this.whatsAppMessageAr,
  });

  factory ScanOrder.fromJson(Map<String, dynamic> json) {
    return ScanOrder(
      id: json['id'],
      orderId: json['order_id'] ?? '',
      trackingNumber: json['tracking_number'] ?? '',
      store: json['store'] ?? '',
      storeImage: json['store_image'] ?? '',
      storePhone: json['store_phone'] ?? '',
      storeEmail: json['store_email'] ?? '',
      clientName: json['client_name'] ?? '',
      clientPhone: json['client_phone'] ?? '',
      clientEmail: json['client_email'] ?? '',
      clientCity: json['client_city'] ?? '',
      clientCityAr: json['client_city_ar'] ?? '',
      clientAddress: json['client_address'] ?? '',
      addressDetails: json['address_details'] ?? '',
      amount: json['amount'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderStatusAr: json['order_status_ar'] ?? '',
      whatsAppMessage: json['what_up_massage'] ?? '',
      whatsAppMessageAr: json['what_up_massage_ar'] ?? '',
    );
  }
}
