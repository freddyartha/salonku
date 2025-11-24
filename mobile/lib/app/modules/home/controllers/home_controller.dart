import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/models/chart_model.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class HomeController extends BaseController {
  late UserModel userData;
  List<MenuItemModel> homeBaseMenus = [];
  final List<ChartModel> chartMingguanList = [];

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
      MenuItemModel(
        title: "transaction",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(
          Routes.SERVICE_MANAGEMENT_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      MenuItemModel(
        title: "expense",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(
          Routes.PENGELUARAN_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
    ]);

    chartMingguanList.clear();
    chartMingguanList.addAll([
      ChartModel(
        label: "Out\n${20.toStringAsFixed(1)}%",
        value: 200000.00,
        color: AppColors.success,
      ),
      ChartModel(
        label: "Out\n${20.toStringAsFixed(1)}%",
        value: 200000.00,
        color: AppColors.success,
      ),
    ]);
    super.onInit();
  }
}
