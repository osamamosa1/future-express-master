import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/scan_order_model.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/network/remote/dio_helper.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/app_url.dart';

part 'pickup_state.dart';

class PickupCubit extends Cubit<PickupState> {
  PickupCubit() : super(PickupInitial());
  static PickupCubit get(context) => BlocProvider.of(context);

  List<ScanOrder>? order = [];
  bool isOrderExists(ScanOrder orderToCheck) {
    return order!.any((order) => order.orderId == orderToCheck.orderId);
  }

  void scanOrder({
    required String code,
  }) async {
    log(code);
    try {
      emit(ScanOrderLoad());
      var response = await DioHelper.postData(
        Url: AppUrl.scan,
        data: FormData.fromMap({
          'order_id': code,
        }),
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> orderData = data['Order'];
        log(orderData[0]['what_up_massage'].toString());
        bool iss = isOrderExists(
            orderData.map((item) => ScanOrder.fromJson(item)).toList().first);
        if (!iss) {
          order!.add(
              orderData.map((item) => ScanOrder.fromJson(item)).toList().first);
        }

        emit(SuccessScanOrderState(scanOrders: order!));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
      if (response.statusCode == 404) {}
    } catch (error) {
      // showToast(message: 'الطلب غير موجود', toastStates: ToastStates.EROOR);
      emit(ScanOrderLoadFailed());
    }
  }

  String? statuseItme;
  Future<void> setPickUp() async {
    FormData formData = FormData();

    for (var index = 0; index < order!.length; index++) {
      var element = order![index];
      // قم بإنشاء معرف مخصص لكل عنصر وقيمته
      formData.fields.add(MapEntry('order_id[$index]', element.id.toString()));
    }
    formData.fields.add(MapEntry('status_id', statuseItme!));

    try {
      emit(ScanOrderLoad());
      var response = await DioHelper.postData(
        Url: AppUrl.pickup,
        data: formData,
      );

      if (response.statusCode == 200) {
        order!.clear();
        emit(SuccessScanOrderState(scanOrders: order!));

        showToast(
            message: response.data['message'],
            toastStates: ToastStates.SUCCESS);
        router.go('/homeLayOut');

        log(response.data['message']);
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      showToast(message: error.toString(), toastStates: ToastStates.EROOR);
      emit(ScanOrderLoadFailed());
    }
  }

  Future<void> removeOrder(ScanOrder orderToRemove) async {
    emit(ScanOrderLoadFailed());

    if (order != null && order!.contains(orderToRemove)) {
      order!.remove(orderToRemove);
      emit(SuccessScanOrderState(scanOrders: [...order!]));
    }
  }

  Future<void> setAllOrder() async {
    emit(SetOrderChange());
  }
}
