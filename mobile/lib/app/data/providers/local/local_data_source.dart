import 'package:get/get.dart';
import 'package:salonku/app/data/models/user_model.dart';

abstract class LocalDataSource extends GetxService {
  //getter
  bool getIsShowOnboarding();

  UserModel get userData;

  bool getIsLoginApple();

  //setter
  Future<void> cacheIsShowOnboarding(bool value);

  Future<void> cacheUser(UserModel user);

  Future<void> clearAllCache();

  Future<void> cacheIsLoginApple(bool isApple);
}
