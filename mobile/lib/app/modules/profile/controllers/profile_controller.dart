import 'package:get/get.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';

import 'package:salonku/app/models/menu_item_model.dart';

class ProfileController extends GetxController {
  final authCon = AuthController.instance;
  final List<MenuItemModel> settingAccountList = [];

  @override
  void onInit() {
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
        onTab: () {},
      ),
    ]);
    super.onInit();
  }

  Future<void> signOutOnTap() async {
    var r = await ReusableWidgets.confirmationBottomSheet(
      children: [
        TextComponent(value: "Kamu yakin ingin keluar dari akun ini?"),
      ],
    );
    if (r == true) {
      await authCon.signOut();
    }
  }

  Future<void> deleteAccountOnTap() async {
    var r = await ReusableWidgets.confirmationBottomSheet(
      children: [
        TextComponent(value: "Kamu yakin ingin menghapus akun ini?"),
        TextComponent(
          value:
              "(Jika kamu menghapus akun ini maka semua data salon dan transaksi akan hilanbg)",
        ),
      ],
    );
    if (r == true) {
      authCon.deleteAccount();
    }
  }
}
