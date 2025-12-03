import 'package:get/get.dart';
import 'package:salonku/app/data/providers/api/pengeluaran_provider.dart';
import 'package:salonku/app/data/repositories/contract/pengeluaran_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/pengeluaran_repository_impl.dart';

import '../controllers/pengeluaran_setup_controller.dart';

class PengeluaranSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengeluaranProvider>(() => PengeluaranProvider());
    Get.lazyPut<PengeluaranRepositoryContract>(
      () => PengeluaranRepositoryImpl(),
    );
    Get.lazyPut<PengeluaranSetupController>(
      () =>
          PengeluaranSetupController(Get.find<PengeluaranRepositoryContract>()),
    );
  }
}
