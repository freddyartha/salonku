import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/models/payment_method_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class PaymentMethodListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final PaymentMethodRepositoryContract _repository;
  PaymentMethodListController(this._repository);

  late final ListComponentController<PaymentMethodModel> listCon;

  @override
  void onInit() {
    listCon = ListComponentController(
      getDataResult: _getList,
      fromDynamic: PaymentMethodModel.fromDynamic,
    );

    searchController.onChanged = (v) => listCon.refresh();
    super.onInit();
  }

  Future<Success<List<PaymentMethodModel>>> _getList(int pageIndex) async {
    Success<List<PaymentMethodModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _repository.getPaymentMethodByIdSalon(
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
      Routes.PAYMENT_METHOD_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => listCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _repository.deletePaymentMethodById(id),
        onSuccess: (res) {
          listCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
