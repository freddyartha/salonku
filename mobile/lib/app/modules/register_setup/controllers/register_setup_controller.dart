import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';

class RegisterSetupController extends GetxController {
  bool isOwner =
      InputFormatter.dynamicToBool(Get.parameters["isOwner"]) ?? false;
  RxBool isDoneSetupSalon = false.obs;

  final namaCon = InputTextController();
  final telpCon = InputTextController(type: InputTextType.phone);
  final nikCon = InputTextController(type: InputTextType.ktp);
  final jenisKelaminCon = InputRadioController(
    items: [
      RadioButtonItem(text: "Laki-laki", value: "l"),
      RadioButtonItem(text: "Perempuan", value: "p"),
    ],
  );
  final tanggalLahirCon = InputDatetimeController();
  final alamatCon = InputTextController(type: InputTextType.paragraf);

  @override
  void onInit() {
    super.onInit();
  }
}
