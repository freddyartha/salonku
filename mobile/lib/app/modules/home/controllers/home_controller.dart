import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class HomeController extends BaseController {
  late UserModel userData;
  List<MenuItemModel> homeBaseMenus = [];

  final LocalDataSource _localDataSource = Get.find();

  @override
  void onInit() {
    userData = _localDataSource.userData;
    homeBaseMenus.addAll([
      MenuItemModel(
        title: "client",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(
          Routes.CLIENT_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
    ]);
    super.onInit();
  }
}
