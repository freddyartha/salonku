import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/models/service_model.dart';

class ServiceSetupController extends SetupBaseController {
  final namaServiceCon = InputTextController();
  final deskripsiCon = InputTextController(type: InputTextType.paragraf);
  final hargaCon = InputTextController(type: InputTextType.money);

  final ServiceRepositoryContract _serviceRepositoryContract;
  final LocalDataSource _localDataSource;
  ServiceSetupController(
    this._serviceRepositoryContract,
    this._localDataSource,
  );

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  ServiceModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getServiceById();
    }
  }

  Future<void> getServiceById() async {
    await handleRequest(
      showLoading: true,
      () => _serviceRepositoryContract.getServiceById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
      ),
      onSuccess: (res) {
        model = res;
        namaServiceCon.value = res.nama;
        deskripsiCon.value = res.deskripsi;
        hargaCon.value = res.harga;
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaServiceCon.isValid) return;
    if (!deskripsiCon.isValid) return;
    if (!hargaCon.isValid) return;

    final model = ServiceModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      nama: namaServiceCon.value,
      deskripsi: deskripsiCon.value,
      harga: hargaCon.value,
      currencyCode: "",
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _serviceRepositoryContract.createService(serviceModelToJson(model))
          : _serviceRepositoryContract.updateService(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              serviceModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        namaServiceCon.value = res.nama;
        deskripsiCon.value = res.deskripsi;
        hargaCon.value = res.harga;
      },
      showErrorSnackbar: false,
    );
  }

  void cancelEditOnTap() {
    namaServiceCon.value = model?.nama;
    deskripsiCon.value = model?.deskripsi;
    hargaCon.value = model?.harga;
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (namaServiceCon.value != null ||
            deskripsiCon.value != null ||
            hargaCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }
}
