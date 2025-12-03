import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/salon_provider.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/salon_repository_impl.dart';

import '../controllers/transaction_list_controller.dart';

class TransactionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalonProvider>(() => SalonProvider());
    Get.lazyPut<SalonRepositoryContract>(() => SalonRepositoryImpl());
    Get.lazyPut<TransactionListController>(
      () => TransactionListController(Get.find<SalonRepositoryContract>()),
    );
  }
}
