import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/income_expense_list_model.dart';
import 'package:salonku/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TransactionListController extends ListBaseController {
  final int idSalon =
      InputFormatter.dynamicToInt(Get.arguments['idSalon']) ?? 0;
  final DateTime fromDate =
      InputFormatter.dynamicToDateTime(Get.arguments['fromDate']) ??
      DateTime.now();
  final DateTime toDate =
      InputFormatter.dynamicToDateTime(Get.arguments['toDate']) ??
      DateTime.now();
  final int? idCabang = InputFormatter.dynamicToInt(Get.arguments['idCabang']);

  final LocalDataSource localDataSource = Get.find();
  final SalonRepositoryContract _salonRepositoryContract;
  TransactionListController(this._salonRepositoryContract);

  late final ListComponentController<IncomeExpenseListModel> serviceListCon;

  @override
  void onInit() {
    serviceListCon = ListComponentController(
      getDataResult: _getIncomeExpenseList,
      fromDynamic: IncomeExpenseListModel.fromDynamic,
    );

    searchController.onChanged = (v) => serviceListCon.refresh();
    super.onInit();
  }

  Future<Success<List<IncomeExpenseListModel>>> _getIncomeExpenseList(
    int pageIndex,
  ) async {
    Success<List<IncomeExpenseListModel>> returnData = Success([]);

    await handlePaginationRequest(
      () => _salonRepositoryContract.getIncomeExpenseList(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: 10,
        fromDate: DateTime.now(),
        toDate: DateTime.now(),
        idCabang:
            ReusableStatics.checkIsUserStaffWithCabang(localDataSource.userData)
            ? localDataSource.userData.cabangs!.first.id
            : null,
        keyword: searchController.value,
      ),
      onSuccess: (res) {
        if (res.data.isNotEmpty) returnData = res;
      },
    );
    return returnData;
  }

  void itemOnTap(int id, String type) {
    Get.toNamed(
      type.toLowerCase() == 'pemasukan'
          ? Routes.SERVICE_MANAGEMENT_SETUP
          : Routes.PENGELUARAN_SETUP,
      arguments: {"id": "$id", "isEdit": "false"},
    )?.then((v) => serviceListCon.refresh());
  }

  Future<void> downloadReportOnTap() async {
    await handleRequest(
      showLoading: false,
      () => _salonRepositoryContract.getTransactionReport(
        idSalon: idSalon,
        fromDate: fromDate,
        toDate: toDate,
        idCabang: idCabang,
      ),
      onSuccess: (res) {
        ReusableWidgets.customBottomSheet(
          title: "transaction_report".tr,
          children: [Expanded(child: SfPdfViewer.network(res))],
        );
      },
    );
  }
}
