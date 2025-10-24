import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';

class ServiceListController extends BaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final ServiceRepositoryContract _serviceRepositoryContract;
  ServiceListController(this._serviceRepositoryContract);

  late final ListComponentController<ServiceModel> serviceListCon;
  final searchCon = InputTextController();

  @override
  void onInit() {
    serviceListCon = ListComponentController(
      getDataResult: _getServiceList,
      fromDynamic: ServiceModel.fromDynamic,
    );
    super.onInit();
  }

  Future<Success<List<ServiceModel>>> _getServiceList(int pageIndex) async {
    Success<List<ServiceModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _serviceRepositoryContract.getServiceList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        keyword: "",
      ),
      onSuccess: (res) {
        returnData = res;
      },
    );
    return returnData;
  }
}
