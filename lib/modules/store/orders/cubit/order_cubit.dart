import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/shared/components/components.dart';
import 'package:future_express/shared/network/remote/dio_helper.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/app_url.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../model/order.dart';
import '../../../../model/order_details.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);
  int currentPage = 1;
  int last_page = 1;
  List<Order>? order = [];
  void getOrderToday({int? currentPage}) async {
    try {
      emit(OrderLoad());
      var response = await DioHelper.getData(
        Url: AppUrl.orderToday,
        query: {'page': currentPage},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> orderData = data['data'];
        log(response.data['meta'].toString());
        last_page = response.data['meta']['last_page'];
        log(response.data['meta']['last_page'].toString());
        // إضافة البيانات الجديدة إلى البيانات الحالية بدلاً من استبدالها
        List<Order> newOrders =
            orderData.map((item) => Order.fromJson(item)).toList();
        emit(SuccessOrderState(orders: [...order!, ...newOrders]));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      showToast(message: "message'", toastStates: ToastStates.EROOR);
      emit(OrderLoadFailed());
    }
  }

  List<Order>? allOrder = [];
  String? nextAll;
  int currentStatusId=0;
  bool loading=false;
   getallOrder() async {
     loading=true;
    try {
      log('getallOrder');
      emit(AllOrderLoad());
      var response = await DioHelper.getData(
        Url:(nextAll==null||nextAll=='finished')? AppUrl.allOrder:nextAll!,
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        Map<String, dynamic> data = response.data;
        List<dynamic> orderData = data['data'];
        if(data['meta']['current_page']<data['meta']['last_page']){
          nextAll=data['links']['next'].toString();

        }else{
          nextAll=null;
        }
          allOrder = orderData.map((item) => Order.fromJson(item)).toList();

        emit(SuccessAllOrderState(Orders: allOrder!));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      showToast(message: "message'", toastStates: ToastStates.EROOR);
      emit(AllOrderLoadFailed());
    }
     loading=false;

   }
   getOrderById(id) async {
     loading=true;
    try {
      log('getOrderById');
      emit(AllOrderLoad());
      var response = await DioHelper.getData(
        Url:(nextAll==null||nextAll=='finished'&&currentStatusId==id)? 'https://future-ex.com/api/v1/git_orders_status?status_id=$id':nextAll!,
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        Map<String, dynamic> data = response.data;
        List<dynamic> orderData = data['data'];
        if(data['meta']['current_page']<data['meta']['last_page']){
          nextAll=data['links']['next'].toString();

        }else{
          nextAll=null;
        }
          allOrder = orderData.map((item) => Order.fromJson(item)).toList();

        emit(SuccessAllOrderState(Orders: allOrder!));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      showToast(message: "message'", toastStates: ToastStates.EROOR);
      emit(AllOrderLoadFailed());
    }
     currentStatusId=id;
     loading=false;

   }
  // getallOrder() async {
  //    loading=true;
  //   try {
  //     log('getallOrder');
  //     emit(AllOrderLoad());
  //     var response = await DioHelper.getData(
  //       Url:(nextAll==null||nextAll=='finished')? AppUrl.allOrder:nextAll!,
  //     );
  //     if (response.statusCode == 200) {
  //       log(response.data.toString());
  //       Map<String, dynamic> data = response.data;
  //       List<dynamic> orderData = data['data'];
  //       if(data['meta']['current_page']<data['meta']['last_page']){
  //         nextAll=data['links']['next'].toString();
  //
  //       }else{
  //         nextAll=null;
  //       }
  //         allOrder = orderData.map((item) => Order.fromJson(item)).toList();
  //
  //       emit(SuccessAllOrderState(Orders: allOrder!));
  //     } else {
  //       // التعامل مع حالة الاستجابة غير الناجحة هنا
  //       print('فشل الاستجابة: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     log(error.toString());
  //     showToast(message: "message'", toastStates: ToastStates.EROOR);
  //     emit(AllOrderLoadFailed());
  //   }
  //    loading=false;
  //
  //  }


  updateOrder(id, statusId,Position position) async {
    try {
      emit(UpdateOrderLoad());
      var response = await DioHelper.postData(
          Url: AppUrl.update,
          data: FormData.fromMap({'id': id, 'status_id': statusId,'latitude':position.latitude,'longitude':position.longitude}));
      log(response.data.toString());
      if (response.statusCode == 200) {
        showToast(
            message: response.data['message'], toastStates: ToastStates.EROOR);
        emit(SuccessUpdateOrder());
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      // showToast(message: "message'", toastStates: ToastStates.EROOR);
      emit(UpdateOrderLoadFailed());
    }
  }

  void confirmOtpCode(code) async {
    try {
      emit(AllOrderLoad());
      var response = await DioHelper.postData(
          Url: AppUrl.confirmOtpCode, data: FormData.fromMap({'code': code}));
      log(response.statusCode.toString());
      log(response.data['message'].toString());
      if (response.statusCode == 200) {
        showToast(
            message: response.data['message'], toastStates: ToastStates.EROOR);
        getallOrder();
        router.go('/homeLayOut');
        emit(UpdateOrderLoad());
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      showToast(message: "message'", toastStates: ToastStates.EROOR);
      emit(UpdateOrderLoadFailed());
    }
  }

  OrderDetails? orderDetails;

  void getOrder(orderId) async {
    try {
      emit(AllOrderLoad());
      var response = await DioHelper.postData(
          Url: AppUrl.orderDetails,
          data: FormData.fromMap({
            'order_id': orderId,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        orderDetails = OrderDetails.fromJson(data['Order'][0]);
        emit(SuccessOrderDetailsState(Orders: orderDetails!));
      } else {
        // التعامل مع حالة الاستجابة غير الناجحة هنا
        print('فشل الاستجابة: ${response.statusCode}');
      }
    } catch (error) {
      log('$error this is error');
      emit(UpdateOrderLoadFailed());
    }
  }
}
