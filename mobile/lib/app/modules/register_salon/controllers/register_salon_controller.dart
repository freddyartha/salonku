import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/models/salon_model.dart';

class RegisterSalonController extends BaseController {
  final _authCon = AuthController.instance;
  final level = InputFormatter.dynamicToInt(Get.parameters['level']) ?? 0;
  final userId = InputFormatter.dynamicToInt(Get.parameters['id_user']) ?? 0;

  //owner
  final InputTextController namaSalonCon = InputTextController();
  final InputTextController alamatSalonCon = InputTextController(
    type: InputTextType.paragraf,
  );
  final InputPhoneController phoneSalonCon = InputPhoneController();

  //staff
  final InputTextController kodeSalonCon = InputTextController();
  SalonModel? salonByKode;
  RxBool isSalonFound = true.obs;

  final SalonRepositoryContract _salonRepositoryContract;
  final UserSalonRepositoryContract _userSalonRepositoryContract;
  final LocalDataSource _localDataSource;
  RegisterSalonController(
    this._salonRepositoryContract,
    this._userSalonRepositoryContract,
    this._localDataSource,
  );

  void clearSalonData() {
    salonByKode = null;
    kodeSalonCon.value = null;
    update();
  }

  Future<void> getSalonByUniqueId() async {
    if (!kodeSalonCon.isValid) return;

    await handleRequest(
      showLoading: true,
      () => _salonRepositoryContract.getSalonByKodeSalon(kodeSalonCon.value),
      onSuccess: (res) async {
        salonByKode = res;
        isSalonFound(true);
        update();
      },
      showErrorSnackbar: false,
      onError: () {
        if (error.value?.statusCode == 404) {
          isSalonFound(false);
        }
        update();
      },
    );
  }

  Future<void> createSalon() async {
    if (!namaSalonCon.isValid) return;
    if (!alamatSalonCon.isValid) return;
    if (!phoneSalonCon.isValid) return;

    final model = SalonModel(
      id: 0,
      namaSalon: namaSalonCon.value,
      kodeSalon: "",
      alamat: alamatSalonCon.value,
      phone: phoneSalonCon.value,
    );

    await handleRequest(
      showLoading: true,
      () => _salonRepositoryContract.createSalon(salonModelToJson(model)),
      onSuccess: (res) async {
        await userAddSalon(userId, res.id);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> userAddSalon(int userId, int salonId) async {
    await handleRequest(
      showLoading: true,
      () => _userSalonRepositoryContract.userAddSalon(userId, salonId),
      onSuccess: (res) async {
        await _localDataSource.cacheUser(res);
        _authCon.setInitialScreen(_authCon.firebaseUser.value);
      },
      showErrorSnackbar: false,
    );
  }
}
