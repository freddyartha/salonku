import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class SettingsController extends BaseController {
  final SalonRepositoryContract _salonRepositoryContract;
  final LocalDataSource _localDataSource;
  SettingsController(this._salonRepositoryContract, this._localDataSource);

  final RxList<MenuItemModel> salonSummaryList = <MenuItemModel>[].obs;
  final List<MenuItemModel> dataUtamaList = [];
  late final UserModel userData;
  SalonModel? salonModel;

  @override
  void onInit() {
    userData = _localDataSource.userData;
    print(userData.idSalon);

    dataUtamaList.addAll([
      MenuItemModel(
        title: "Servis",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(
          Routes.SERVICE_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      MenuItemModel(
        title: "Produk",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(Routes.PROFILE),
      ),
      MenuItemModel(
        title: "Supplier",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(Routes.PROFILE),
      ),
      MenuItemModel(
        title: "Metode Pembayaran",
        imageLocation: "assets/images/png/settings.png",
        onTab: () => Get.toNamed(Routes.PROFILE),
      ),
    ]);
    super.onInit();
  }

  Future<void> getSalonSummary() async {
    await handleRequest(
      showEasyLoading: false,
      () => _salonRepositoryContract.getSalonSummary(userData.idSalon ?? 0),
      onSuccess: (res) async {
        salonSummaryList.clear();
        salonSummaryList.addAll([
          MenuItemModel(
            title: "Jumlah Cabang",
            value: res.jumlahCabang.toString(),
          ),
          MenuItemModel(
            title: "Jumlah Staff",
            value: res.jumlahStaff.toString(),
          ),
        ]);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> getSalonById() async {
    await handleRequest(
      showEasyLoading: false,
      () => _salonRepositoryContract.getSalonById(userData.idSalon ?? 0),
      onSuccess: (res) {
        print(res.logoUrl);
        salonModel = res;
        getSalonSummary();
      },
    );
  }
}
