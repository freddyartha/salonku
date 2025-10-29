import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class SalonCabangListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final SalonRepositoryContract _salonRepositoryContract;
  SalonCabangListController(this._salonRepositoryContract);

  late final ListComponentController<SalonCabangModel> serviceListCon;

  @override
  void onInit() {
    serviceListCon = ListComponentController(
      getDataResult: _getList,
      fromDynamic: SalonCabangModel.fromDynamic,
    );
    searchController.onChanged = (v) => serviceListCon.refresh();

    super.onInit();
  }

  Future<Success<List<SalonCabangModel>>> _getList(int pageIndex) async {
    Success<List<SalonCabangModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _salonRepositoryContract.getCabangByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        keyword: searchController.value,
      ),
      onSuccess: (res) {
        returnData = res;
      },
    );
    return returnData;
  }

  void itemOnTap(int id, bool isEdit) {
    Get.toNamed(
      Routes.SALON_CABANG_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit", "idSalon": "$idSalon"},
    )?.then((v) => serviceListCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _salonRepositoryContract.deleteCabangById(id),
        onSuccess: (res) {
          serviceListCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
