import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseAPI {
  final fireBaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {    await fireBaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmToken = await fireBaseMessaging.getToken();
    print("FCMtoken : $fcmToken");
  }
   
}
