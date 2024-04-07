class OrderDetails {
  final int? id;
  final String? orderId;
  final String? trackingNumber;
  final String? store;
  final String? storeImage;
  final String? storePhone;
  final String? storeEmail;
  final String? clientName;
  final String? clientPhone;
  final String? clientEmail;
  final String? clientCity;
  final String? clientCityAr;
  final String? clientRegion;
  final String? clientRegionAr;
  final String? addressDetails;
  final String? orderStatus;
  final String? orderStatusAr;
  final String? availableCollectOrderStatus;
  final int? numberCount;
  final int? callCount;
  final int? whatAppCount;
  final int? isFinished;
  final int? amountPaid;
  final String? amount;
  final String? longitude;
  final String? latitude;
  final String? whatUpMassage;
  final String? whatUpMassageAr;

  OrderDetails({
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
    required this.longitude,
    required this.latitude,
    required this.whatUpMassage,
    required this.whatUpMassageAr,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      orderId: json['order_id'],
      trackingNumber: json['tracking_number'],
      store: json['store'],
      storeImage: json['store_image'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      storePhone: json['store_phone'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      storeEmail: json['store_email'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      clientName: json['client_name'],
      clientPhone: json['client_phone'],
      clientEmail: json['client_email'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      clientCity: json['client_city'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      clientCityAr: json['client_city_ar'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      clientRegion: json['client_region'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      clientRegionAr: json['client_region_ar'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      addressDetails: json['address_details'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      orderStatus: json['order_status'],
      orderStatusAr: json['order_status_ar'],
      availableCollectOrderStatus: json['available_collect_order_status'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      numberCount: json['number_count'],
      callCount: json['call_count'],
      whatAppCount: json['whatApp_count'],
      isFinished: json['is_finished'],
      amountPaid: json['amount_paid'],
      amount: json['amount'] ?? '',
      longitude: json['longitude'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      latitude: json['latitude'] ??
          '', // يمكن أن يكون 'null'، لذا استخدم قيمة افتراضية
      whatUpMassage: json['what_up_massage'],
      whatUpMassageAr: json['what_up_massage_ar'],
    );
  }
}
