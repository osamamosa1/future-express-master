import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/notificationModel.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';

import '../../home/cubit/home_cubit.dart';
import '../../restaurant_delivery/orders/cubit/order_cubit.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationResponse? notificationResponse;

  // StreamController لإرسال التحديثات
  final _controller = StreamController<NotificationState>.broadcast();

  // Stream للاستماع إلى التحديثات
  @override
  Stream<NotificationState> get stream => _controller.stream;

  Future<void> fetchNotification() async {
    try {
      final token = await CacheHelper.getToken();
      log(token.toString());
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://future-ex.com/api/notifications',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        notificationResponse = NotificationResponse.fromJson(data);

        // إرسال التحديث للاستماع إليه في الـ CurrentOrders
        emit(NotificationFetched(notificationResponse!.notifications.data));
      } else {
        throw Exception('فشل في استدعاء ال API');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> sendToken() async {
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      log(deviceToken.toString());

      log(deviceToken!);
      final token = await CacheHelper.getToken();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = FormData.fromMap({'Token_Device': deviceToken});

      var dio = Dio();
      var response = await dio.request(
        'https://future-ex.com/api/Token_Device',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> initFirebaseMessaging(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // استمع لرسائل FCM عند فتح التطبيق من الخلفية
      updateDataFromNotification(context);
      log('the app is work in background eqrgfr${message.data['route']}');
    });

    // يجب استدعاء getInitialMessage في initState

    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('TERMINATED');
        final redirectRoute = message.data['route'];
        print('redirectRoute $redirectRoute');

        updateDataFromNotification(context);

        //remove redirect route here, so the unknownRoute will trigger the default route
      }
    });
    //only works if app in foreground
    FirebaseMessaging.onMessage.listen((message) {
      log(message.data.toString());      log('${message.from!}aaaaaaaaaaaaaaaaaaaaaaaaaa');

      updateDataFromNotification(context);
    });

    //onclick notif system tray only works if app in background but not termi
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final redirectRoute = message.data;
      print('BACKGROUND');
      print('redirectRoute $redirectRoute');
    });
  }

  Future<void> updateDataFromNotification(context) async {
    try {
      // تحديث البيانات عند تلقي إشعار

      emit(NotificationsNewOrder());
      _controller.add(NotificationsNewOrder());
      OrdersRestaurantCubit.get(context).getOrderById(context.read<HomeCubit>().statusesItems![0].id);

      print('add log');
    } catch (error) {
      // التعامل مع الأخطاء إذا كان هناك
    }
  }

  // ... باقي الكود
}
