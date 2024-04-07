import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/restaurant_delivery/current_orders/widget/footer_order_current.dart';
import 'package:future_express/modules/restaurant_delivery/current_orders/widget/heder_current_order.dart';
import 'package:future_express/modules/restaurant_delivery/current_orders/widget/slider_oreder_current.dart';
import 'package:future_express/modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../layouts/cubit/cubit.dart';
import '../../home/cubit/home_cubit.dart';
import '../../notification/cubit/notification_cubit.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({super.key});

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {

  Position? position;
  bool? statusDone=false;
  bool? locationAcces;

  Future<void> checkAndRequestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      position=await Geolocator.getCurrentPosition();
        locationAcces=true;
    } else {
      locationAcces=false;

    }
    setState(() {});

  }
  getStatus()async{
    await HomeCubit.get(context).getStatuses();
    statusDone=true;
  }
  @override
  void initState() {
    getStatus();
    checkAndRequestLocationPermission();
    // استدعاء دالة updateActiveStatus لتحديث حالة الحساب النشطة
    unawaited(AppCubit.get(context).updateActiveStatus());
    // استدعاء دالة initFirebaseMessaging لتكوين الاستماع لرسائل FCM
    unawaited(NotificationCubit.get(context).initFirebaseMessaging(context));

    // باقي الكود الخاص بك
    // استدعاء دالة init لتكوين الاستماع لرسائل FCM
    unawaited(HomeCubit.get(context).init());
    // استدعاء دالة fetchNotification لجلب الإشعارات
    unawaited(NotificationCubit.get(context).fetchNotification());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (statusDone!=true||position==null)?Center(child: CircularProgressIndicator(),):
    BlocProvider(
      create: (context) => OrdersRestaurantCubit()..getOrderById(context.read<HomeCubit>().statusesItems![0].id),
      child: BlocBuilder<OrdersRestaurantCubit, OrdersRestaurantState>(
        buildWhen: (previous, current) =>
        previous != current && current is SuccessAllOrderState,
        builder: (context, state) {
          return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  // unawaited(AppCubit.get(context).updateActiveStatus());
                  // unawaited(HomeCubit.get(context).getStatuses());
                  // unawaited(HomeCubit.get(context).init());
                  await context.read<OrdersRestaurantCubit>().getOrderById(context.read<HomeCubit>().statusesItems![0].id);
                },
                child: ListView(
                  children:  [
                    HederCurrentOder(),
                    SliderCurrentOrder(),
                    FooterOrderCurrent(position: position),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
