import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage _box = GetStorage();

  // Keys
  static const String _isShowOnboarding = 'is_show_onboarding';

  // isFirstInstall
  static bool get isShowOnboarding => _box.read(_isShowOnboarding) ?? false;
  static set isShowOnboarding(bool value) =>
      _box.write(_isShowOnboarding, value);

  // Clear all
  static void clear() {
    _box.erase();
  }
}
