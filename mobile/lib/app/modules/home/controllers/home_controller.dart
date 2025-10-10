import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';

class HomeController extends GetxController {
  final testCon = InputTextController();
  final test1Con = InputTextController();
  final testRadioCon = InputRadioController(
    items: [RadioButtonItem.simple("Test 1"), RadioButtonItem.simple("Test 2")],
  );

  @override
  void onInit() {
    test1Con.value = "makanan kesukaan";
    super.onInit();
  }
}
