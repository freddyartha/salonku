import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';

class SalonCabangSetupController extends SetupBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments["idSalon"]) ?? 0;
  final namaCabangCon = InputTextController();
  final alamatCon = InputTextController(type: InputTextType.paragraf);
  final InputPhoneController phoneCon = InputPhoneController();

  final SalonRepositoryContract _salonRepositoryContract;
  SalonCabangSetupController(this._salonRepositoryContract);

  SalonCabangModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getDataById();
    }
  }

  void _addValueInputFields(SalonCabangModel model) {
    namaCabangCon.value = model.nama;
    alamatCon.value = model.alamat;
    phoneCon.value = model.phone;
  }

  Future<void> getDataById() async {
    await handleRequest(
      showLoading: true,
      () => _salonRepositoryContract.getCabangById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
      ),
      onSuccess: (res) {
        model = res;
        _addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaCabangCon.isValid) return;
    if (!alamatCon.isValid) return;
    if (!phoneCon.isValid) return;

    final model = SalonCabangModel(
      id: 0,
      idSalon: idSalon,
      nama: namaCabangCon.value,
      alamat: alamatCon.value,
      phone: phoneCon.value,
    );
    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _salonRepositoryContract.createCabang(salonCabangModelToJson(model))
          : _salonRepositoryContract.updateCabangById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              salonCabangModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        _addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  void cancelEditOnTap() {
    namaCabangCon.value = model?.nama;
    alamatCon.value = model?.alamat;
    phoneCon.value = model?.phone;
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (namaCabangCon.value != null ||
            alamatCon.value != null ||
            phoneCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }
}
