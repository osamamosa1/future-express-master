
class OrderRestaurantDetails {
  final int? id;
  final String? orderId;
  final String? trackingNumber;
  final String? store;
  final dynamic storeImage;
  final dynamic storePhone;
  final String? storeEmail;
  final String? storeBranch;
  final dynamic storeLongitude;
  final dynamic storeLatitude;
  final String? clientName;
  final String? clientPhone;
  final String? clientCity;
  final String? clientCityAr;
  final String? clientRegion;
  final String? clientRegionAr;
  final dynamic addressDetails;
  final String? orderStatus;
  final String? orderStatusAr;
  final dynamic availableCollectOrderStatus;
  final int? numberCount;
  final int? callCount;
  final int? whatAppCount;
  final int? isFinished;
  final int? amountPaid;
  final String? amount;
  final dynamic longitude;
  final dynamic latitude;
  final dynamic realImageConfirm;
  final String? whatUpMassage;
  final String? whatUpMassageAr;
  final List<Product>? product;

  OrderRestaurantDetails({
    this.id,
    this.orderId,
    this.trackingNumber,
    this.store,
    this.storeImage,
    this.storePhone,
    this.storeEmail,
    this.storeBranch,
    this.storeLongitude,
    this.storeLatitude,
    this.clientName,
    this.clientPhone,
    this.clientCity,
    this.clientCityAr,
    this.clientRegion,
    this.clientRegionAr,
    this.addressDetails,
    this.orderStatus,
    this.orderStatusAr,
    this.availableCollectOrderStatus,
    this.numberCount,
    this.callCount,
    this.whatAppCount,
    this.isFinished,
    this.amountPaid,
    this.amount,
    this.longitude,
    this.latitude,
    this.realImageConfirm,
    this.whatUpMassage,
    this.whatUpMassageAr,
    this.product,
  });

  factory OrderRestaurantDetails.fromJson(Map<String, dynamic> json) => OrderRestaurantDetails(
    id: json['id'],
    orderId: json['order_id'],
    trackingNumber: json['tracking_number'],
    store: json['store'],
    storeImage: json['store_image'],
    storePhone: json['store_phone'],
    storeEmail: json['store_email'],
    storeBranch: json['store_branch'],
    storeLongitude: json['store_longitude'],
    storeLatitude: json['store_latitude'],
    clientName: json['client_name'],
    clientPhone: json['client_phone'],
    clientCity: json['client_city'],
    clientCityAr: json['client_city_ar'],
    clientRegion: json['client_region'],
    clientRegionAr: json['client_region_ar'],
    addressDetails: json['address_details'],
    orderStatus: json['order_status'],
    orderStatusAr: json['order_status_ar'],
    availableCollectOrderStatus: json['available_collect_order_status'],
    numberCount: json['number_count'],
    callCount: json['call_count'],
    whatAppCount: json['whatApp_count'],
    isFinished: json['is_finished'],
    amountPaid: json['amount_paid'],
    amount: json['amount'],
    longitude: json['longitude'],
    latitude: json['latitude'],
    realImageConfirm: json['real_image_confirm'],
    whatUpMassage: json['what_up_massage'],
    whatUpMassageAr: json['what_up_massage_ar'],
    product: json['product'] == null ? [] : List<Product>.from(json['product']!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'tracking_number': trackingNumber,
    'store': store,
    'store_image': storeImage,
    'store_phone': storePhone,
    'store_email': storeEmail,
    'store_branch': storeBranch,
    'store_longitude': storeLongitude,
    'store_latitude': storeLatitude,
    'client_name': clientName,
    'client_phone': clientPhone,
    'client_city': clientCity,
    'client_city_ar': clientCityAr,
    'client_region': clientRegion,
    'client_region_ar': clientRegionAr,
    'address_details': addressDetails,
    'order_status': orderStatus,
    'order_status_ar': orderStatusAr,
    'available_collect_order_status': availableCollectOrderStatus,
    'number_count': numberCount,
    'call_count': callCount,
    'whatApp_count': whatAppCount,
    'is_finished': isFinished,
    'amount_paid': amountPaid,
    'amount': amount,
    'longitude': longitude,
    'latitude': latitude,
    'real_image_confirm': realImageConfirm,
    'what_up_massage': whatUpMassage,
    'what_up_massage_ar': whatUpMassageAr,
    'product': product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class Product {
  final int? id;
  final String? productName;
  final String? size;
  final int? number;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? orderId;
  final dynamic deletedAt;
  final dynamic sku;

  Product({
    this.id,
    this.productName,
    this.size,
    this.number,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.deletedAt,
    this.sku,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    productName: json['product_name'],
    size: json['size'],
    number: json['number'],
    price: json['price'],
    createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
    updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
    orderId: json['order_id'],
    deletedAt: json['deleted_at'],
    sku: json['sku'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_name': productName,
    'size': size,
    'number': number,
    'price': price,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'order_id': orderId,
    'deleted_at': deletedAt,
    'sku': sku,
  };
}
