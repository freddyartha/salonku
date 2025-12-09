import 'package:get/get.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/income_expense_model.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class HomeController extends BaseController {
  late UserModel userData;
  List<MenuItemModel> homeBaseMenus = [];

  final LocalDataSource localDataSource = Get.find();
  final SalonRepositoryContract _salonRepository = Get.find();

  IncomeExpenseModel? todayTransactionModel;
  IncomeExpenseModel? thisMonthTransactionModel;

  @override
  void onInit() {
    userData = localDataSource.userData;
    homeBaseMenus.addAll([
      MenuItemModel(
        title: "client",
        imageLocation: "assets/images/png/clients.png",
        onTab: () => Get.toNamed(
          Routes.CLIENT_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      MenuItemModel(
        title: "transaction",
        imageLocation: "assets/images/png/transaction.png",
        onTab: () => Get.toNamed(
          Routes.SERVICE_MANAGEMENT_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        )?.then((_) => getTotalTransactionSummary()),
      ),
      MenuItemModel(
        title: "expense",
        imageLocation: "assets/images/png/expense.png",
        onTab: () => Get.toNamed(
          Routes.PENGELUARAN_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        )?.then((_) => getTotalTransactionSummary()),
      ),
    ]);

    getTotalTransactionSummary();

    super.onInit();
  }

  Future<void> getTotalTransactionSummary() async {
    todayTransactionModel = await getTransactionSummary(
      DateTime.now(),
      DateTime.now(),
    );
    thisMonthTransactionModel = await getTransactionSummary(
      DateTime.now(),
      ReusableStatics.lastDayOfMonth(DateTime.now()),
    );
    update();
  }

  Future<IncomeExpenseModel?> getTransactionSummary(
    DateTime fromDate,
    DateTime toDate,
  ) async {
    IncomeExpenseModel? returnModel;
    await handleRequest(
      showEasyLoading: false,
      () => _salonRepository.getIncomeExpenseSummary(
        localDataSource.salonData.id,
        localDataSource.userData.cabangs != null &&
                localDataSource.userData.cabangs!.isNotEmpty
            ? localDataSource.userData.cabangs!.first.id
            : null,
        fromDate,
        toDate,
      ),
      onSuccess: (res) {
        returnModel = res;
      },
      showErrorSnackbar: false,
    );
    return returnModel;
  }
}
