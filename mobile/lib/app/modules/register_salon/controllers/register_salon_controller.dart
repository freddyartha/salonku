import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class RegisterSalonController extends BaseController {
  RxInt selectedLevel = 0.obs;
  // final List<MenuItemModel> registerTypeList = [];

  //owner
  final InputTextController namaSalonCon = InputTextController();
  final InputTextController alamatSalonCon = InputTextController(
    type: InputTextType.paragraf,
  );
  final InputTextController telpSalonCon = InputTextController(
    type: InputTextType.phone,
  );

  //staff
  final InputTextController nikOwnerCon = InputTextController();
  final InputTextController emailOwnerCon = InputTextController(
    type: InputTextType.email,
  );

  final SalonRepositoryContract _salonRepositoryContract;
  RegisterSalonController(this._salonRepositoryContract);

  @override
  void onInit() {
    // registerTypeList.addAll([
    //   MenuItemModel(
    //     title: "owner",
    //     imageLocation: "assets/images/png/owner.png",
    //     onTab: () => selectedLevel.value = 1,
    //   ),
    //   MenuItemModel(
    //     title: "staff",
    //     imageLocation: "assets/images/png/staff.png",
    //     onTab: () => selectedLevel.value = 2,
    //   ),
    // ]);
    super.onInit();
  }

  Future<void> createSalon() async {
    if (!namaSalonCon.isValid) return;
    if (!alamatSalonCon.isValid) return;
    if (!telpSalonCon.isValid) return;

    final model = SalonModel(
      id: 0,
      namaSalon: namaSalonCon.value,
      kodeSalon: "",
      alamat: alamatSalonCon.value,
      phone: telpSalonCon.value,
    );
    await handleRequest(
      showLoading: true,
      () => _salonRepositoryContract.createSalon(salonModelToJson(model)),
      onSuccess: (res) {
        Get.toNamed(Routes.REGISTER_SETUP);
      },
      showErrorSnackbar: false,
      onError: () {
        ReusableWidgets.notifBottomSheet(subtitle: error.value?.message ?? "");
      },
    );
  }
}
