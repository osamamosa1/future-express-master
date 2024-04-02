import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/layouts/cubit/cubit.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/modules/notification/cubit/notification_cubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../model/order.dart';
import '../../../../model/order_rest/order/order.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/utils/app_url.dart';

part 'order_state.dart';

class OrdersRestaurantCubit extends Cubit<OrdersRestaurantState> {
  OrdersRestaurantCubit() : super(OrdersRestaurantInitial());
  static OrdersRestaurantCubit get(context) => BlocProvider.of(context);

  List<Order>? allOrder = [];

   getAllOrder() async {
      try {
        emit(AllOrderLoad());
        var response = await DioHelper.getData(
          Url: AppUrl.newOrdersRestaurant,
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> data = response.data;
          List<dynamic> orderData = data['data'];

          allOrder = orderData.map((item) => Order.fromJson(item)).toList();
          print(allOrder);
          emit(SuccessAllOrderState(Orders: allOrder!));
        } else {
          emit(AllOrderLoadFailed());

          // التعامل مع حالة الاستجابة غير الناجحة هنا
          print('فشل الاستجابة: ${response.statusCode}');
        }
      } catch (error) {
        showToast(message: error.toString(), toastStates: ToastStates.EROOR);
        emit(AllOrderLoadFailed());
      }


  }

  OrdersRestaurant? orderRestaurant;

  void getOrder(orderId) async {
    FormData data = FormData.fromMap({
      'order_id': orderId,
    });
    try {
      emit(OrderLoad());
      var response = await DioHelper.postData(
          Url: AppUrl.ordersRestaurantDetails, data: data);

      if (response.statusCode == 200) {
        log(response.data['Order'].toString());
        var orderData = response.data['Order'].first;
        orderRestaurant = OrdersRestaurant.fromJson(orderData);
        log(orderRestaurant!.id.toString());
        emit(SuccessOrderState(Orders: orderRestaurant!));
      } else {
        emit(OrderLoadFailed());

        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      showToast(message: error.toString(), toastStates: ToastStates.EROOR);
      emit(OrderLoadFailed());
    }
  }

  bool isConfirm = false;
  Future<void> updateOrder(
      id, statusId, BuildContext context, bool bool) async {
    if (!bool) context.pop(context);
    isConfirm = false;
    try {
      emit(UpdateOrderLoad());

      var response = await DioHelper.postData(
          Url: AppUrl.update,
          data: FormData.fromMap({'id': id, 'status_id': statusId}));
      emit(UpdateOrderLoaded());
      isConfirm = true;

      log('messageaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa id $id , statusId $statusId');

      if (response.statusCode == 200) {
        showToast(
            message: response.data['message'], toastStates: ToastStates.EROOR);
        Navigator.pop(context);
        unawaited(AppCubit.get(context).updateActiveStatus());

        // استدعاء دالة initFirebaseMessaging لتكوين الاستماع لرسائل FCM
        unawaited(NotificationCubit.get(context).initFirebaseMessaging(context));

        // باقي الكود الخاص بك
        unawaited(HomeCubit.get(context).getStatuses());
        // استدعاء دالة init لتكوين الاستماع لرسائل FCM
        unawaited(HomeCubit.get(context).init());
        // استدعاء دالة fetchNotification لجلب الإشعارات
        unawaited(NotificationCubit.get(context).fetchNotification());
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      emit(UpdateOrderLoadFailed());
    }
  }

  void confirmOtpCode(code,Position position) async {
    try {
      emit(ConfirmOrderLoad());
      var response = await DioHelper.postData(
          Url: AppUrl.confirmOtpCode, data: FormData.fromMap({'code': code}));

      if (response.statusCode == 200) {
        showToast(
            message: response.data['message'], toastStates: ToastStates.EROOR);
        emit(ConfirmOrderLoaded());
        getOrder(orderRestaurant!.id);
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      showToast(message: 'هذا الكود غير صالح', toastStates: ToastStates.EROOR);
      emit(ConfirmOrderLoadFailed());
    }
  }

  XFile? avatar;

  ImageSource? source;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getAvatar(id) async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImages != null) {
      avatar = selectedImages;
      emit(SetAvatarImageState());
      await setImage(avatar, id);
    }
    emit(SetImageState());
  }

  Future<void> setImage(XFile? avatar, id) async {
    FormData data = FormData.fromMap({
      'order_id': id,
      'real_image_confirm':
          await MultipartFile.fromFile(avatar!.path, filename: avatar.name),
    });
    await DioHelper.postData(
      Url: AppUrl.realImage,
      data: data,
    ).then((value) => showToast(
        message: value.data['message'], toastStates: ToastStates.SUCCESS));
  }
}
