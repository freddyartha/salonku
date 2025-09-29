import 'package:get/get.dart';
import 'package:mobile/app/data/models/auth_model.dart';
import 'package:mobile/app/data/models/user_model.dart';

abstract class LocalDataSource extends GetxService {
  bool getIsShowOnboarding();

  String getUserName();

  String getPhoneNumber();

  int getUserId();

  String getUserAvatar();

  bool getUserIsLogin();

  String getAccessToken();

  UserModel? get userData;

  Future<void> cacheIsShowOnboarding(bool value);

  Future<void> cacheAuth(AuthModel data);

  Future<void> cacheUser(UserModel? user);

  Future<void> clearAllCache();
}
