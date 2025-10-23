import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  void onStartPage() {
    Get.find<LocalDataSource>().cacheIsShowOnboarding(false);
    Get.offNamed(Routes.LOGIN);
  }
}
