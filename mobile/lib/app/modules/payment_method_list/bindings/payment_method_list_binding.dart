import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/payment_method_provider.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/payment_method_repository_impl.dart';

import '../controllers/payment_method_list_controller.dart';

class PaymentMethodListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodProvider>(() => PaymentMethodProvider());
    Get.lazyPut<PaymentMethodRepositoryContract>(
      () => PaymentMethodRepositoryImpl(),
    );
    Get.lazyPut<PaymentMethodListController>(
      () => PaymentMethodListController(
        Get.find<PaymentMethodRepositoryContract>(),
      ),
    );
  }
}
