import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/others/select_single_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/product_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/models/product_model.dart';
import 'package:salonku/app/models/select_item_model.dart';
import 'package:salonku/app/models/supplier_model.dart';

class ProductSetupController extends SetupBaseController {
  final brandCon = InputTextController();
  final namaCon = InputTextController();
  final ukuranCon = InputTextController();
  final satuanCon = InputTextController();
  final hargaSatuanCon = InputTextController(type: InputTextType.money);

  final ProductRepositoryContract _repository;
  final LocalDataSource _localDataSource;
  final SupplierRepositoryContract _supplierRepository;
  ProductSetupController(
    this._repository,
    this._localDataSource,
    this._supplierRepository,
  );

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  ProductModel? model;

  late final SelectSingleController selectSupplierCon;

  @override
  void onInit() {
    super.onInit();
    setupSelectSingleController();
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

      if (model.supplier != null) {
        selectSupplierCon.value = SelectItemModel(
          title: model.supplier?.nama ?? "",
          subtitle: model.supplier?.alamat ?? "",
          value: model.supplier?.id,
        );
      }
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
      idSupplier: selectSupplierCon.value?.value,
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

  void setupSelectSingleController() {
    Future<Success<List<SelectItemModel>>> getSupplierByIdSalon(
      int pageIndex,
    ) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        () => _supplierRepository.getSupplierByIdSalon(
          idSalon: _localDataSource.salonData.id,
          pageIndex: pageIndex,
          pageSize: 10,
          keyword: selectSupplierCon.keyword,
        ),
        onSuccess: (res) {
          returnData = Success(
            res.data
                .map(
                  (e) => SelectItemModel(
                    value: e.id,
                    title: e.nama,
                    subtitle: e.phone,
                  ),
                )
                .toList(),
            meta: res.meta,
            message: res.message,
          );
        },
      );
      return returnData;
    }

    final listCon = ListComponentController(
      getDataResult: getSupplierByIdSalon,
      fromDynamic: SupplierModel.fromDynamic,
    );
    selectSupplierCon = SelectSingleController(listController: listCon);
  }
}
