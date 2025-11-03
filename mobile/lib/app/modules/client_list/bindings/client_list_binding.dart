import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/client_provider.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/client_repository_impl.dart';

import '../controllers/client_list_controller.dart';

class ClientListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientProvider>(() => ClientProvider());
    Get.lazyPut<ClientRepositoryContract>(() => ClientRepositoryImpl());
    Get.lazyPut<ClientListController>(
      () => ClientListController(Get.find<ClientRepositoryContract>()),
    );
  }
}
