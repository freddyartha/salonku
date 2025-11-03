import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/supplier_repository_contract.dart';
import 'package:salonku/app/models/supplier_model.dart';

class SupplierSetupController extends SetupBaseController {
  final namaSupplierCon = InputTextController();
  final alamatSupplierCon = InputTextController(type: InputTextType.paragraf);
  final phoneSupplierCon = InputPhoneController();

  final SupplierRepositoryContract _repository;
  final LocalDataSource _localDataSource = Get.find();
  SupplierSetupController(this._repository);

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  SupplierModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
  }

  void addValueInputFields(SupplierModel? model) {
    if (model != null) {
      namaSupplierCon.value = model.nama;
      alamatSupplierCon.value = model.alamat;
      phoneSupplierCon.value = model.phone;
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () =>
          _repository.getSupplierById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaSupplierCon.isValid) return;
    if (!alamatSupplierCon.isValid) return;
    if (!phoneSupplierCon.isValid) return;

    final model = SupplierModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      nama: namaSupplierCon.value,
      alamat: alamatSupplierCon.value,
      phone: phoneSupplierCon.value,
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _repository.createSupplier(supplierModelToJson(model))
          : _repository.updateSupplierById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              supplierModelToJson(model),
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
        (namaSupplierCon.value != null ||
            alamatSupplierCon.value != null ||
            phoneSupplierCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }
}
