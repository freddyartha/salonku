import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/payment_method_provider.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/payment_method_repository_impl.dart';

import '../controllers/payment_method_setup_controller.dart';

class PaymentMethodSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodProvider>(() => PaymentMethodProvider());
    Get.lazyPut<PaymentMethodRepositoryContract>(
      () => PaymentMethodRepositoryImpl(),
    );
    Get.lazyPut<PaymentMethodSetupController>(
      () => PaymentMethodSetupController(
        Get.find<PaymentMethodRepositoryContract>(),
      ),
    );
  }
}
