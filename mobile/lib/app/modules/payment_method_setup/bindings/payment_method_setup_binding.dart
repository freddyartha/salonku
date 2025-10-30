import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/payment_method_repository_impl.dart';

import '../controllers/payment_method_setup_controller.dart';

class PaymentMethodSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodRepositoryContract>(
      () => PaymentMethodRepositoryImpl(),
    );
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl());
    Get.lazyPut<PaymentMethodSetupController>(
      () => PaymentMethodSetupController(
        Get.find<PaymentMethodRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
  }
}
