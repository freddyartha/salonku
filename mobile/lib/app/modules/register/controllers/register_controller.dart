import 'package:get/get.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxInt selectedLevel = 0.obs;
  final List<MenuItemModel> registerTypeList = [];

  @override
  void onInit() {
    registerTypeList.addAll([
      MenuItemModel(
        title: "owner",
        imageLocation: "assets/images/png/owner.png",
        onTab: () =>
            Get.toNamed(Routes.REGISTER_SETUP, parameters: {"level": "1"}),
      ),
      MenuItemModel(
        title: "staff",
        imageLocation: "assets/images/png/staff.png",
        onTab: () =>
            Get.toNamed(Routes.REGISTER_SETUP, parameters: {"level": "2"}),
      ),
    ]);
    super.onInit();
  }
}
