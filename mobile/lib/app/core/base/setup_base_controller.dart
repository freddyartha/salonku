import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/core/base/base_controller.dart';

abstract class SetupBaseController extends BaseController {
  dynamic itemId = Get.parameters['id'];
  final dynamic editParam = Get.parameters['isEdit'];
  final RxBool isEditable = false.obs;

  @override
  void onInit() {
    if (itemId == null) {
      isEditable(true);
    } else if (itemId != null &&
        InputFormatter.dynamicToBool(editParam) != false) {
      isEditable(true);
    }
    super.onInit();
  }
}
