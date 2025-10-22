import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/models/salon_model.dart';

class OwnerApprovalController extends BaseController {
  final _authCon = AuthController.instance;
  final bool? approved = InputFormatter.dynamicToBool(
    Get.parameters["approved"],
  );
  final int _userId =
      InputFormatter.dynamicToInt(Get.parameters["userId"]) ?? 0;
  final int _salonId =
      InputFormatter.dynamicToInt(Get.parameters["salonId"]) ?? 0;

  SalonModel? salonModel;

  final UserSalonRepositoryContract _userSalonRepositoryContract;
  final SalonRepositoryContract _salonRepositoryContract;
  OwnerApprovalController(
    this._userSalonRepositoryContract,
    this._salonRepositoryContract,
  );

  @override
  void onInit() {
    getSalonById();
    super.onInit();
  }

  Future<void> userRemoveSalon() async {
    await handleRequest(
      showLoading: true,
      () => _userSalonRepositoryContract.userRemoveSalon(_userId),
      onSuccess: (res) {
        _authCon.setInitialScreen(_authCon.firebaseUser.value);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> getSalonById() async {
    await handleRequest(
      showLoading: true,
      () => _salonRepositoryContract.getSalonById(_salonId),
      onSuccess: (res) {
        salonModel = res;
      },
      showErrorSnackbar: false,
      onFinish: update,
    );
  }
}
