import 'package:get/get.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  void logout() {
    AuthController.instance.signOut();
  }

  List<MenuItemModel> registerTypeList = [
    MenuItemModel(
      title: "owner",
      imageLocation: "assets/images/png/owner.png",
      onTab: () =>
          Get.toNamed(Routes.REGISTER_SETUP, parameters: {"isOwner": "true"}),
    ),
    MenuItemModel(
      title: "staff",
      imageLocation: "assets/images/png/staff.png",
      onTab: () =>
          Get.toNamed(Routes.REGISTER_SETUP, parameters: {"isOwner": "false"}),
    ),
  ];
}
