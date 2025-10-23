import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';

import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/user_model.dart';

class ProfileController extends GetxController {
  final authCon = AuthController.instance;
  final List<MenuItemModel> settingAccountList = [];

  late UserModel userModel;

  final LocalDataSource _localDataSource;
  ProfileController(this._localDataSource);

  @override
  void onInit() {
    userModel = _localDataSource.userData;
    settingAccountList.addAll([
      MenuItemModel(
        id: 1,
        title: "sign_out",
        imageLocation: "assets/images/png/sign_out.png",
        onTab: signOutOnTap,
      ),
      MenuItemModel(
        id: 1,
        title: "delete_account",
        imageLocation: "assets/images/png/delete_account.png",
        onTab: deleteAccountOnTap,
      ),
    ]);
    super.onInit();
  }

  void signOutOnTap() {
    authCon.signOut();
  }

  Future<void> deleteAccountOnTap() async {
    var r = await ReusableWidgets.confirmationBottomSheet(
      children: [
        TextComponent(
          value: "delete_account_title".tr,
          textAlign: TextAlign.center,
          fontWeight: FontWeights.semiBold,
        ),
        TextComponent(
          value: "delete_account_warning".tr,
          textAlign: TextAlign.center,
        ),
      ],
    );
    if (r == true) {
      authCon.deleteAccount();
    }
  }
}
