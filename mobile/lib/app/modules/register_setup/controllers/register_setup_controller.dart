import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class RegisterSetupController extends BaseController {
  final level = InputFormatter.dynamicToInt(Get.parameters['level']) ?? 0;
  final namaCon = InputTextController();
  final telpCon = InputTextController(type: InputTextType.phone);
  final nikCon = InputTextController();
  final jenisKelaminCon = InputRadioController(
    items: [
      RadioButtonItem(text: "Laki-laki", value: "l"),
      RadioButtonItem(text: "Perempuan", value: "p"),
    ],
  );
  final tanggalLahirCon = InputDatetimeController();
  final alamatCon = InputTextController(type: InputTextType.paragraf);

  final UserSalonRepositoryContract _userSalonRepositoryContract;
  RegisterSetupController(this._userSalonRepositoryContract);

  Future<void> registerUser() async {
    if (!namaCon.isValid) return;
    if (!telpCon.isValid) return;
    if (!nikCon.isValid) return;
    if (!jenisKelaminCon.isValid) return;
    if (!tanggalLahirCon.isValid) return;
    if (!alamatCon.isValid) return;

    final model = UserModel(
      id: 0,
      idUserFirebase: AuthController.instance.firebaseUser.value?.uid ?? "",
      level: level,
      nama: namaCon.value,
      email: AuthController.instance.firebaseUser.value?.email ?? "",
      phone: telpCon.value,
      nik: nikCon.value,
      jenisKelamin: jenisKelaminCon.value,
      tanggalLahir: tanggalLahirCon.value,
      alamat: alamatCon.value,
    );

    await handleRequest(
      showLoading: true,
      () => _userSalonRepositoryContract.registerUser(userModelToJson(model)),
      onSuccess: (res) {
        Get.toNamed(
          Routes.REGISTER_SALON,
          parameters: {"level": level.toString(), "id_user": res.id.toString()},
        );
      },
      showErrorSnackbar: false,
    );
  }
}
