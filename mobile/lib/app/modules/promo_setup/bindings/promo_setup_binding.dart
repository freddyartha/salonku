import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/promo_provider.dart';
import 'package:salonku/app/data/repositories/contract/promo_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/promo_repository_impl.dart';

import '../controllers/promo_setup_controller.dart';

class PromoSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoProvider>(() => PromoProvider());
    Get.lazyPut<PromoRepositoryContract>(() => PromoRepositoryImpl());
    Get.lazyPut<PromoSetupController>(
      () => PromoSetupController(Get.find<PromoRepositoryContract>()),
    );
  }
}
