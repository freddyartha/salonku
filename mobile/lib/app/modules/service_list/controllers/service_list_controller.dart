import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';

class ServiceListController extends BaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final ServiceRepositoryContract _serviceRepositoryContract;
  ServiceListController(this._serviceRepositoryContract);

  @override
  void onInit() {
    print(idSalon);
    getServiceList(1);
    super.onInit();
  }

  Future<void> getServiceList(int pageIndex) async {
    print("masuk sini");

    await handleRequest(
      showEasyLoading: false,
      () => _serviceRepositoryContract.getServiceList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        keyword: "",
      ),
      onSuccess: (res) async {
        print(res.length);
      },
      showErrorSnackbar: false,
    );
  }
}
