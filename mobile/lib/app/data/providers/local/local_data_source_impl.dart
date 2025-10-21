import 'package:get_storage/get_storage.dart';
import 'package:salonku/app/core/constants/storage_key.dart';
import 'package:salonku/app/models/user_model.dart';

import 'local_data_source.dart';

class LocalDataSourceImpl extends LocalDataSource {
  late GetStorage _box;

  Future<LocalDataSource> init() async {
    await GetStorage.init('salonKuPref');
    _box = GetStorage('salonKuPref');
    return this;
  }

  @override
  Future<void> cacheIsShowOnboarding(bool value) {
    return _box.write(StorageKey.cachedIsShowOnboardingKey, value);
  }

  @override
  UserModel get userData {
    final userData = _box.read(StorageKey.cachedUserDataKey);
    print(userData);
    return UserModel.fromDynamic(userData);
  }

  @override
  bool getIsShowOnboarding() {
    final isShowOnboarding = _box.read(StorageKey.cachedIsShowOnboardingKey);
    return isShowOnboarding ?? true;
  }

  @override
  Future<void> clearAllCache() {
    return _box.erase();
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    var userJson = userModelToJson(user);
    await _box.write(StorageKey.cachedUserDataKey, userJson);
  }

  @override
  Future<void> cacheIsLoginApple(bool isApple) async {
    await _box.write(StorageKey.cachedAppleLoginKey, isApple);
  }

  @override
  bool getIsLoginApple() {
    final isApple = _box.read(StorageKey.cachedAppleLoginKey);
    return isApple ?? false;
  }
}
