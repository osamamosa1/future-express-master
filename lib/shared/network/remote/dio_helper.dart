// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';

import '../../utils/app_url.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: basesUrl,
        followRedirects: true,
        receiveDataWhenStatusError: true,
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if (statusCode == 422) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    );
  }

  static Future<Response> getData({
    required String Url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? auth,
  }) async {
    var token = await CacheHelper.getToken();
    dio.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await dio.get(
      Url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String Url,
    required FormData data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? auth,
  }) async {
    var token = await CacheHelper.getToken();

    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return dio.post(Url, queryParameters: query, data: data);
  }
}
