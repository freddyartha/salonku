import 'package:get/get.dart';

import 'package:salonku/app/models/menu_item_model.dart';

class ProfileController extends GetxController {
  final List<MenuItemModel> settingAccountList = [];

  @override
  void onInit() {
    settingAccountList.addAll([
      MenuItemModel(
        id: 1,
        title: "sign_out",
        imageLocation: "assets/images/png/sign_out.png",
        onTab: () {},
      ),
      MenuItemModel(
        id: 1,
        title: "delete_account",
        imageLocation: "assets/images/png/delete_account.png",
        onTab: () {},
      ),
    ]);
    super.onInit();
  }
}
