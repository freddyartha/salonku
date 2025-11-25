import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/chart_model.dart';
import 'package:salonku/app/models/income_expense_model.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class HomeController extends BaseController {
  late UserModel userData;
  List<MenuItemModel> homeBaseMenus = [];
  final List<ChartModel> chartMingguanList = [];

  final LocalDataSource localDataSource = Get.find();
  final SalonRepositoryContract _salonRepository = Get.find();

  IncomeExpenseModel? model;

  @override
  void onInit() {
    userData = localDataSource.userData;
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

    getTotalIncomeExpense();

    super.onInit();
  }

  Future<void> getTotalIncomeExpense() async {
    await handleRequest(
      showLoading: true,
      () => _salonRepository.getIncomeExpenseSummary(
        localDataSource.salonData.id,
        localDataSource.userData.cabangs != null &&
                localDataSource.userData.cabangs!.isNotEmpty
            ? localDataSource.userData.cabangs!.first.id
            : null,
        DateTime.now(),
        DateTime.now(),
      ),
      onSuccess: (res) {
        model = res;
        update();
      },
      showErrorSnackbar: false,
    );
  }
}
