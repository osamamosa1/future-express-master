import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/store/orders/screens/orders_screen.dart';
import 'package:future_express/modules/technicalSupport/TechnicalSupportScreen.dart';
import 'package:future_express/shared/network/remote/dio_helper.dart';
import 'package:future_express/shared/utils/app_url.dart';
import 'package:future_express/shared/widgets/confirmation_dialog.dart';
import 'package:future_express/shared/widgets/custom_alert_dialog%20copy.dart';
import 'package:get/get.dart' as geet;
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/account/screens/my_account_screen.dart';

import '../../modules/home/screens/home_screen.dart';
import '../../modules/restaurant_delivery/current_orders/current_orders.dart';
import '../../modules/restaurant_delivery/orders/screens/orders_screen.dart';
import '../../modules/wallet/screens/my_wallet_screen.dart';
import 'package:geolocator/geolocator.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectionSubscription;

  AppCubit() : super(AppInitialState(ConnectionStatus.online)) {
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((_) => unawaited(_checkInternetConnection()));
    unawaited(_checkInternetConnection());
  }

  static AppCubit get(context) => BlocProvider.of(context);

  Future<void> _checkInternetConnection() async {
    try {
      // Sometimes the callback is called when we reconnect to wifi, but the internet is not really functional
      // This delay try to wait until we are really connected to internet
      await Future.delayed(const Duration(seconds: 2));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(ConnectionStatusOnlineState());
      } else {
        emit(ConnectionStatusOfflineState());
      }
    } on SocketException catch (_) {
      emit(ConnectionStatusOfflineState());
    }
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();

    return super.close();
  }

  List<Widget> bottomScreens = [
    const OrdersScreen(),
    const MyWalletScreen(),
    const HomeScreen(),
    const TechnicalSupport(),
    const MyAccountScreen(),
  ];
  List<Widget> bottomScreensRestaurnt = [
    const OrdersRestaurant(),
    const MyWalletScreen(),
    const CurrentOrders(),
    const TechnicalSupport(),
    const MyAccountScreen(),
  ];
  Future<void> updateActiveStatus() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        (geet.GetPlatform.isIOS
            ? false
            : permission == LocationPermission.whileInUse)) {
      await geet.Get.dialog(
          ConfirmationDialog(
            icon: 'assets/image/location_permission.png',
            iconSize: 200,
            hasCancel: false,
            description:
                'This app collects location data to enable location fetching at the time of your online status, even when the app is closed or not in use.',
            onYesPressed: () {
              geet.Get.back();
              _checkPermission(() => startLocationRecord());
            },
          ),
          barrierDismissible: false);
    } else {
      startLocationRecord();
    }
  }

  Timer? _timer;

  void _checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        (geet.GetPlatform.isIOS
            ? false
            : permission == LocationPermission.whileInUse)) {
      await geet.Get.dialog(
          CustomAlertDialog(
              description: 'you_denied'.tr,
              onOkPressed: () async {
                geet.Get.back();
                await Geolocator.requestPermission();
                _checkPermission(callback);
              }),
          barrierDismissible: false);
    } else if (permission == LocationPermission.deniedForever) {
      await geet.Get.dialog(
          CustomAlertDialog(
              description: 'you_denied_forever'.tr,
              onOkPressed: () async {
                geet.Get.back();
                await Geolocator.openAppSettings();
                _checkPermission(callback);
              }),
          barrierDismissible: false);
    } else {
      callback();
    }
  }

  void startLocationRecord() {
    // _location.enableBackgroundMode(enable: true);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      unawaited(recordLocation());
    });
  }

  void stopLocationRecord() {
    // _location.enableBackgroundMode(enable: false);
    _timer?.cancel();
  }

  Future<void> recordLocation() async {
    final Position locationResult = await Geolocator.getCurrentPosition();

    // قراءة اللوكيشن السابقة
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? previousLatitude = prefs.getDouble('keyLatitude');
    double? previousLongitude = prefs.getDouble('keyLongitude');

    // مقارنة اللوكيشن الحالية بالسابقة
    if (previousLatitude == null ||
        previousLongitude == null ||
        (locationResult.latitude != previousLatitude ||
            locationResult.longitude != previousLongitude)) {
      // إرسال اللوكيشن إذا كانت مختلفة
      FormData data = FormData.fromMap({
        'lat': locationResult.latitude,
        'long': locationResult.longitude,
      });
      await DioHelper.postData(Url: AppUrl.location, data: data)
          .then((value) => print(value));

      // تحديث اللوكيشن السابقة
      await prefs.setDouble('keyLatitude', locationResult.latitude);
      await prefs.setDouble('keyLongitude', locationResult.longitude);
    } else {
      print('Same location, no need to send data.');
    }
  }
}

enum ConnectionStatus {
  online,
  offline,
}
