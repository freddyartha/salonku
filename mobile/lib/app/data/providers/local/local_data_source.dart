import 'package:get/get.dart';
import 'package:salonku/app/data/models/auth_model.dart';
import 'package:salonku/app/data/models/user_model.dart';

abstract class LocalDataSource extends GetxService {
  //getter
  bool getIsShowOnboarding();

  String getUserName();

  String getPhoneNumber();

  int getUserId();

  String getUserAvatar();

  bool getUserIsLogin();

  String getAccessToken();

  UserModel? get userData;

  bool getAppTheme();

  //setter
  Future<void> cacheIsShowOnboarding(bool value);

  Future<void> cacheAuth(AuthModel data);

  Future<void> cacheUser(UserModel? user);

  Future<void> clearAllCache();

  Future<void> cacheAppTheme(bool isDark);
}
