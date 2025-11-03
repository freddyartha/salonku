import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/models/client_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class ClientListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final ClientRepositoryContract _repository;
  ClientListController(this._repository);

  late final ListComponentController<ClientModel> listCon;

  @override
  void onInit() {
    listCon = ListComponentController(
      getDataResult: _getList,
      fromDynamic: ClientModel.fromDynamic,
    );

    searchController.onChanged = (v) => listCon.refresh();
    super.onInit();
  }

  Future<Success<List<ClientModel>>> _getList(int pageIndex) async {
    Success<List<ClientModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _repository.getClientByIdSalon(
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
      Routes.CLIENT_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => listCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _repository.deleteClientById(id),
        onSuccess: (res) {
          listCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
