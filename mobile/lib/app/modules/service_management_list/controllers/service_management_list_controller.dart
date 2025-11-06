import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/service_management_repository_contract.dart';
import 'package:salonku/app/models/service_management_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class ServiceManagementListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final ServiceManagementRepositoryContract _repository;
  final LocalDataSource _localDataSource = Get.find();
  ServiceManagementListController(this._repository);

  late final ListComponentController<ServiceManagementModel> listCon;

  @override
  void onInit() {
    listCon = ListComponentController(
      getDataResult: _getList,
      fromDynamic: ServiceManagementModel.fromDynamic,
    );

    searchController.onChanged = (v) => listCon.refresh();
    super.onInit();
  }

  Future<Success<List<ServiceManagementModel>>> _getList(int pageIndex) async {
    Success<List<ServiceManagementModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _repository.getServiceManagementByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        keyword: searchController.value,
        idCabang:
            ReusableStatics.checkIsUserStaffWithCabang(
              _localDataSource.userData,
            )
            ? _localDataSource.userData.cabangs!.first.id
            : null,
      ),
      onSuccess: (res) {
        returnData = res;
      },
    );
    return returnData;
  }

  void itemOnTap(int id, bool isEdit) {
    Get.toNamed(
      Routes.SERVICE_MANAGEMENT_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => listCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _repository.deleteServiceManagementById(id),
        onSuccess: (res) {
          listCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
