
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCv2U-lHheE-BngV2OVoCiOv0xNqsrzl8k',
    appId: '"1:102696219660:android:74ffaf17eda9ddc3c9ea29',
    messagingSenderId: '102696219660',
    projectId: 'decoded-jigsaw-402013',
    storageBucket: 'decoded-jigsaw-402013.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCqZGFM1jMWUMiffPcSui8GYAb-994WUk',
    appId: '1:624633824908:ios:ee42d871fd37a6428e9da9',
    messagingSenderId: '624633824908',
    projectId: 'fir-pushtest-efcd8',
    storageBucket: 'fir-pushtest-efcd8.appspot.com',
    iosBundleId: 'com.example.firebasepushtest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'Your macOS apiKey',
    appId: 'Your macOS appId',
    messagingSenderId: 'Your macOS messagingSenderId',
    projectId: 'Your macOS projectId',
    storageBucket: 'Your macOS storageBucket',
  );
}