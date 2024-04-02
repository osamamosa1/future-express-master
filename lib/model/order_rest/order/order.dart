import 'product.dart';

class OrdersRestaurant {
  int id;
  String orderId;
  String trackingNumber;
  String store;
  String storeImage;
  String storePhone;
  String storeEmail;
  String storeBranch;
  String? storeLongitude;
  String? storeLatitude;
  String clientName;
  String clientPhone;
  String clientCity;
  String clientCityAr;
  String clientRegion;
  String clientRegionAr;
  String addressDetails;
  String orderStatus;
  String orderStatusAr;
  String availableCollectOrderStatus;
  int numberCount;
  int callCount;
  int whatAppCount;
  int isFinished;
  int amountPaid;
  String amount;
  String? longitude;
  String? latitude;
  String realImageConfirm;
  String whatUpMassage;
  String whatUpMassageAr;
  List<Product> productList;

  OrdersRestaurant({
    required this.id,
    required this.orderId,
    required this.trackingNumber,
    required this.store,
    required this.storeImage,
    required this.storePhone,
    required this.storeEmail,
    required this.storeBranch,
    this.storeLongitude,
    this.storeLatitude,
    required this.clientName,
    required this.clientPhone,
    required this.clientCity,
    required this.clientCityAr,
    required this.clientRegion,
    required this.clientRegionAr,
    required this.addressDetails,
    required this.orderStatus,
    required this.orderStatusAr,
    required this.availableCollectOrderStatus,
    required this.numberCount,
    required this.callCount,
    required this.whatAppCount,
    required this.isFinished,
    required this.amountPaid,
    required this.amount,
    this.longitude,
    this.latitude,
    required this.realImageConfirm,
    required this.whatUpMassage,
    required this.whatUpMassageAr,
    required this.productList,
  });

  factory OrdersRestaurant.fromJson(Map<String, dynamic> json) {
    return OrdersRestaurant(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? '',
      trackingNumber: json['tracking_number'] ?? '',
      store: json['store'] ?? '',
      storeImage: json['store_image'] ?? '',
      storePhone: json['store_phone'] ?? '',
      storeEmail: json['store_email'] ?? '',
      storeBranch: json['store_branch'] ?? '',
      storeLongitude: json['store_longitude']??'',
      storeLatitude: json['store_latitude']??'',
      clientName: json['client_name'] ?? '',
      clientPhone: json['client_phone'] ?? '',
      clientCity: json['client_city'] ?? '',
      clientCityAr: json['client_city_ar'] ?? '',
      clientRegion: json['client_region'] ?? '',
      clientRegionAr: json['client_region_ar'] ?? '',
      addressDetails: json['address_details'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderStatusAr: json['order_status_ar'] ?? '',
      availableCollectOrderStatus: json['available_collect_order_status'] ?? '',
      numberCount: json['number_count'] ?? 0,
      callCount: json['call_count'] ?? 0,
      whatAppCount: json['whatApp_count'] ?? 0,
      isFinished: json['is_finished'] ?? 0,
      amountPaid: json['amount_paid'] ?? 0,
      amount: json['amount'] ?? '',
      longitude: json['longitude']??'',
      latitude: json['latitude']??'',
      realImageConfirm: json['real_image_confirm'] ?? '',
      whatUpMassage: json['what_up_massage'] ?? '',
      whatUpMassageAr: json['what_up_massage_ar'] ?? '',
      productList: (json['product'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}