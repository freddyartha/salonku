import 'dart:ui';

import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

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

  void itemOnTap(int id, bool isEdit) {
    Get.toNamed(
      Routes.SERVICE_SETUP,
      parameters: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => serviceListCon.refresh());
  }

  Future<void> deletData(int id) async {
    var r = await ReusableWidgets.confirmationBottomSheet(
      children: [
        TextComponent(
          value: "delete_confirmation".tr,
          textAlign: TextAlign.center,
        ),
      ],
    );

    if (r == true) {
      await handleRequest(
        showLoading: true,
        () => _serviceRepositoryContract.deleteServiceById(id),
        onSuccess: (res) {
          serviceListCon.refresh();
        },
        showErrorSnackbar: false,
      );
    }
  }
}
