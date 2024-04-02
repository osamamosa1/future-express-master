import 'dart:async';
import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:future_express/shared/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static const _secureStorage = FlutterSecureStorage();
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Locale? get locale {
    final value = sharedPreferences.getString('locale');

    if (value == null) {
      return null;
    }

    return Locale(value);
  }

  static void changeLocale(String locale) {
    unawaited(sharedPreferences.setString('locale', locale));
  }

  static Future<bool> putBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<String?> getToken() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token;
  }

  static Future<void> setToken(String? token) async {
    await _secureStorage.write(
      key: 'access_token',
      value: token,
    );
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<void> deleteToken() async {
    await sharedPreferences.remove(AppStrings.token);
  }
}


enum MyCacheKey{
  userReport,
  user,
  token,
}