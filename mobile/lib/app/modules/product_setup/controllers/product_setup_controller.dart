import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/models/product_model.dart';

class ProductSetupController extends SetupBaseController {
  final brandCon = InputTextController();
  final namaCon = InputTextController();
  final ukuranCon = InputTextController();
  final satuanCon = InputTextController();
  final hargaSatuanCon = InputTextController(type: InputTextType.money);

  final ProductRepositoryContract _repository;
  final LocalDataSource _localDataSource;
  ProductSetupController(this._repository, this._localDataSource);

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  ProductModel? model;

  late final SelectMultipleController selectSupplierCon;

  @override
  void onInit() {
    super.onInit();
    setupSelectMultipleController();
    if (itemId != null) {
      getById();
    }
  }

  void addValueInputFields(ProductModel? model) {
    if (model != null) {
      brandCon.value = model.brand;
      namaCon.value = model.nama;
      ukuranCon.value = model.ukuran;
      satuanCon.value = model.satuan;
      hargaSatuanCon.value = model.hargaSatuan;

      // if (model.cabang != null && model.cabang!.isNotEmpty) {
      //   selectCabangCon.values = model.cabang!
      //       .map(
      //         (e) =>
      //             SelectItemModel(title: e.nama, subtitle: e.phone, value: e.id),
      //       )
      //       .toList();
      // }
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () =>
          _repository.getProductById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!brandCon.isValid) return;
    if (!namaCon.isValid) return;
    if (!ukuranCon.isValid) return;
    if (!satuanCon.isValid) return;
    if (!hargaSatuanCon.isValid) return;

    final model = ProductModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      idSupplier: null,
      brand: brandCon.value,
      nama: namaCon.value,
      satuan: satuanCon.value,
      ukuran: ukuranCon.value,
      hargaSatuan: hargaSatuanCon.value,
      currencyCode: "",
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _repository.createProduct(productModelToJson(model))
          : _repository.updateProductById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              productModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (brandCon.value != null ||
            namaCon.value != null ||
            ukuranCon.value != null ||
            satuanCon.value != null ||
            hargaSatuanCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }

  void setupSelectMultipleController() {
    // Future<Success<List<SelectItemModel>>> getCabangByIdSalon(
    //   int pageIndex,
    // ) async {
    //   Success<List<SelectItemModel>> returnData = Success([]);
    //   await handlePaginationRequest(
    //     () => _salonRepositoryContract.getCabangByIdSalon(
    //       idSalon: _localDataSource.salonData.id,
    //       pageIndex: pageIndex,
    //       pageSize: 10,
    //       keyword: selectCabangCon.keyword,
    //     ),
    //     onSuccess: (res) {
    //       returnData = Success(
    //         res.data
    //             .map(
    //               (e) => SelectItemModel(
    //                 value: e.id,
    //                 title: e.nama,
    //                 subtitle: e.phone,
    //               ),
    //             )
    //             .toList(),
    //         meta: res.meta,
    //         message: res.message,
    //       );
    //     },
    //   );
    //   return returnData;
    // }

    // final listCon = ListComponentController(
    //   getDataResult: getCabangByIdSalon,
    //   fromDynamic: SalonCabangModel.fromDynamic,
    // );
    // selectCabangCon = SelectMultipleController(listController: listCon);
  }
}
