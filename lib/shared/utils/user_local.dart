import 'package:future_express/shared/network/local/cache_helper.dart';

class UserLocal {
 static int? get userReport => CacheHelper.getData(key: MyCacheKey.userReport.name);
 static int? get userType => CacheHelper.getData(key: MyCacheKey.user.name);
 static String? get token => CacheHelper.getData(key: MyCacheKey.token.name);

}
