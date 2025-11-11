import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/client_provider.dart';
import 'package:salonku/app/data/providers/api/payment_method_provider.dart';
import 'package:salonku/app/data/providers/api/promo_provider.dart';
import 'package:salonku/app/data/providers/api/service_management_provider.dart';
import 'package:salonku/app/data/providers/api/service_provider.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/promo_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_management_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/client_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/payment_method_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/promo_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/service_management_repository_impl.dart';
import 'package:salonku/app/data/repositories/implementation/service_repository_impl.dart';

import '../controllers/service_management_setup_controller.dart';

class ServiceManagementSetupBinding extends Bindings {
  @override
  void dependencies() {
    //provider
    Get.lazyPut<ClientProvider>(() => ClientProvider());
    Get.lazyPut<PaymentMethodProvider>(() => PaymentMethodProvider());
    Get.lazyPut<ServiceProvider>(() => ServiceProvider());
    Get.lazyPut<ServiceManagementProvider>(() => ServiceManagementProvider());
    Get.lazyPut<PromoProvider>(() => PromoProvider());

    //repository
    Get.lazyPut<ClientRepositoryContract>(() => ClientRepositoryImpl());
    Get.lazyPut<PaymentMethodRepositoryContract>(
      () => PaymentMethodRepositoryImpl(),
    );
    Get.lazyPut<ServiceRepositoryContract>(() => ServiceRepositoryImpl());
    Get.lazyPut<ServiceManagementRepositoryContract>(
      () => ServiceManagementRepositoryImpl(),
    );
    Get.lazyPut<PromoRepositoryContract>(() => PromoRepositoryImpl());

    Get.lazyPut<ServiceManagementSetupController>(
      () => ServiceManagementSetupController(
        Get.find<ClientRepositoryContract>(),
        Get.find<PaymentMethodRepositoryContract>(),
        Get.find<ServiceRepositoryContract>(),
        Get.find<ServiceManagementRepositoryContract>(),
        Get.find<PromoRepositoryContract>(),
      ),
    );
  }
}
