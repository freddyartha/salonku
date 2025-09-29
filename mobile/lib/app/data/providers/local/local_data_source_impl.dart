import 'package:get_storage/get_storage.dart';
import 'package:mobile/app/core/constants/storage_key.dart';
import 'package:mobile/app/data/models/auth_model.dart';
import 'package:mobile/app/data/models/user_model.dart';

import 'local_data_source.dart';

class LocalDataSourceImpl extends LocalDataSource {
  late GetStorage _box;

  Future<LocalDataSource> init() async {
    await GetStorage.init('SuperAppPref');
    _box = GetStorage('SuperAppPref');
    return this;
  }

  @override
  Future<void> cacheIsShowOnboarding(bool value) {
    return _box.write(StorageKey.cachedIsShowOnboardingKey, value);
  }

  @override
  UserModel? get userData {
    final userData = _box.read(StorageKey.cachedUserDataKey);
    if (userData == null) return null;
    return UserModel.fromJson(userData);
  }

  @override
  String getUserName() {
    final userName = _box.read(StorageKey.cachedUserNameKey);
    return userName ?? "";
  }

  @override
  String getPhoneNumber() {
    final phone = _box.read(StorageKey.cachedUserPhoneKey);
    return phone ?? "";
  }

  @override
  int getUserId() {
    final userId = _box.read(StorageKey.cachedUserDataKey)?['id'];
    return userId ?? 0;
  }

  @override
  String getUserAvatar() {
    final userAvatar = _box.read(StorageKey.cachedUserAvatarKey);
    return userAvatar ?? "";
  }

  @override
  bool getUserIsLogin() {
    final isLogin = _box.read(StorageKey.cachedUserIsLoginKey);
    return isLogin ?? false;
  }

  @override
  bool getIsShowOnboarding() {
    final isShowOnboarding = _box.read(StorageKey.cachedIsShowOnboardingKey);
    return isShowOnboarding ?? false;
  }

  @override
  String getAccessToken() {
    final accessToken = _box.read(StorageKey.cachedAccessTokenKey);
    return accessToken ?? "";
  }

  @override
  Future<void> clearAllCache() {
    return _box.erase();
  }

  @override
  Future<void> cacheAuth(AuthModel data) async {
    final accessToken = data.accessToken;
    final refreshToken = '';
    await _box.write(StorageKey.cachedUserIsLoginKey, true);
    await _box.write(StorageKey.cachedUserDataKey, data.user.toJson());
    await _box.write(StorageKey.cachedUserNameKey, data.user.name);
    await _box.write(StorageKey.cachedUserPhoneKey, data.user.phoneNumber);
    await _box.write(StorageKey.cachedUserAvatarKey, data.user.avatarUrl);
    await _box.write(StorageKey.cachedAccessTokenKey, accessToken);
    await _box.write(StorageKey.cachedRefreshTokenKey, refreshToken);
  }

  @override
  Future<void> cacheUser(UserModel? user) async {
    await _box.write(StorageKey.cachedUserDataKey, user?.toJson());
    await _box.write(StorageKey.cachedUserNameKey, user?.name);
    await _box.write(StorageKey.cachedUserPhoneKey, user?.phoneNumber);
    await _box.write(StorageKey.cachedUserAvatarKey, user?.avatarUrl);
  }
}
