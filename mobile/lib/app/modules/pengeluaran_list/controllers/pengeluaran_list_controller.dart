import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/pengeluaran_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class PengeluaranListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final LocalDataSource _localDataSource = Get.find();
  final PengeluaranRepositoryContract _pengeluaranRepositoryContract;
  PengeluaranListController(this._pengeluaranRepositoryContract);

  late final ListComponentController<ServiceModel> serviceListCon;

  @override
  void onInit() {
    serviceListCon = ListComponentController(
      getDataResult: _getPengeluaranList,
      fromDynamic: ServiceModel.fromDynamic,
    );

    searchController.onChanged = (v) => serviceListCon.refresh();
    super.onInit();
  }

  Future<Success<List<ServiceModel>>> _getPengeluaranList(int pageIndex) async {
    Success<List<ServiceModel>> returnData = Success([]);

    await handlePaginationRequest(
      () => _pengeluaranRepositoryContract.getPengeluaranList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        idCabang:
            ReusableStatics.checkIsUserStaffWithCabang(
              _localDataSource.userData,
            )
            ? _localDataSource.userData.cabangs!.first.id
            : null,
        keyword: searchController.value,
      ),
      onSuccess: (res) {
        if (res.data.isNotEmpty) returnData = res;
      },
    );
    return returnData;
  }

  void itemOnTap(int id, bool isEdit) {
    Get.toNamed(
      Routes.PENGELUARAN_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => serviceListCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _pengeluaranRepositoryContract.deletePengeluaranById(id),
        onSuccess: (res) {
          serviceListCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
