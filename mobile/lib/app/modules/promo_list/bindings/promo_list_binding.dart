import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/promo_provider.dart';
import 'package:salonku/app/data/repositories/contract/promo_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/promo_repository_impl.dart';

import '../controllers/promo_list_controller.dart';

class PromoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoProvider>(() => PromoProvider());
    Get.lazyPut<PromoRepositoryContract>(() => PromoRepositoryImpl());
    Get.lazyPut<PromoListController>(
      () => PromoListController(Get.find<PromoRepositoryContract>()),
    );
  }
}
