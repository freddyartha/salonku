import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/models/product_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class ProductListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;

  final ProductRepositoryContract _repository;
  ProductListController(this._repository);

  late final ListComponentController<ProductModel> listCon;

  @override
  void onInit() {
    listCon = ListComponentController(
      getDataResult: _getList,
      fromDynamic: ProductModel.fromDynamic,
    );

    searchController.onChanged = (v) => listCon.refresh();
    super.onInit();
  }

  Future<Success<List<ProductModel>>> _getList(int pageIndex) async {
    Success<List<ProductModel>> returnData = Success([]);
    await handlePaginationRequest(
      () => _repository.getProductByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
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
      Routes.PRODUCT_SETUP,
      arguments: {"id": "$id", "isEdit": "$isEdit"},
    )?.then((v) => listCon.refresh());
  }

  Future<void> deletData(int id) async {
    await deleteData(
      () async => await handleRequest(
        showLoading: true,
        () => _repository.deleteProductById(id),
        onSuccess: (res) {
          listCon.refresh();
        },
        showErrorSnackbar: false,
      ),
    );
  }
}
