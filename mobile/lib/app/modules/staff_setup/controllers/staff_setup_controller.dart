import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/staff_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/select_item_model.dart';
import 'package:salonku/app/models/user_model.dart';

class StaffSetupController extends SetupBaseController {
  final approvedDate = InputDatetimeController();
  final namaCon = InputTextController();
  final levelCon = InputTextController();
  final emailCon = InputTextController(type: InputTextType.email);
  final phoneCon = InputPhoneController();
  final nikCon = InputTextController();
  final jenisKelaminCon = InputRadioController(
    items: ReusableStatics.jenisKelaminRadioItem,
  );
  final tanggalLahirCon = InputDatetimeController();
  final alamatCon = InputTextController(type: InputTextType.paragraf);

  final LocalDataSource localDataSource = Get.find();
  final SalonRepositoryContract _salonRepository = Get.find();
  final StaffRepositoryContract _repository;
  final UserSalonRepositoryContract _userSalonRepository;
  StaffSetupController(this._repository, this._userSalonRepository);

  RxInt userLevel = 2.obs;

  UserModel? model;

  final approveCon = InputRadioController(
    items: [
      RadioButtonItem(text: "approve".tr, value: true),
      RadioButtonItem(text: "decline".tr, value: false),
    ],
  );
  late final SelectMultipleController selectCabangCon;

  @override
  void onInit() {
    super.onInit();
    setupSelectMultipleController();
    if (itemId != null) {
      getById();
    }
    localDataSource.userData.level == 1 && model?.approvedDate != null
        ? isEditable(true)
        : isEditable(false);
  }

  void addValueInputFields(UserModel? model) {
    if (model != null) {
      namaCon.value = model.nama;
      levelCon.value = ReusableStatics.getLevelUser(model.level);
      emailCon.value = model.email;
      phoneCon.value = model.phone;
      nikCon.value = model.nik;
      jenisKelaminCon.value = model.jenisKelamin;
      approvedDate.value = model.approvedDate;
      tanggalLahirCon.value = model.tanggalLahir;
      alamatCon.value = model.alamat;

      if (model.cabangs != null && model.cabangs!.isNotEmpty) {
        selectCabangCon.values = model.cabangs!
            .map(
              (e) => SelectItemModel(
                title: e.nama,
                subtitle: e.phone,
                value: e.id,
              ),
            )
            .toList();
      }
    }
  }

  Future<void> staffApproval() async {
    if (!approveCon.isValid) return;
    if (!selectCabangCon.isValid) return;

    await handleRequest(
      () => _userSalonRepository.staffApproval(
        model?.id ?? 0,
        selectCabangCon.values.map((e) => e.value as int).toList(),
        approveCon.value,
      ),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> promoteDemoteStaff(bool promote) async {
    await handleRequest(
      () => _repository.promoteDemoteStaff(
        InputFormatter.dynamicToInt(itemId) ?? 0,
        promote,
      ),
      onSuccess: (res) {
        model = res;
        userLevel(res.level);
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _repository.getStaffById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
        userLevel(res.level);
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaCon.isValid) return;
    if (!emailCon.isValid) return;
    if (!phoneCon.isValid) return;
    if (!nikCon.isValid) return;
    if (!jenisKelaminCon.isValid) return;
    if (!tanggalLahirCon.isValid) return;
    if (!alamatCon.isValid) return;

    final model = UserModel(
      id: 0,
      aktif: true,
      idUserFirebase: "",
      level: 2,
      nama: namaCon.value,
      email: emailCon.value,
      phone: phoneCon.value,
      nik: nikCon.value,
      jenisKelamin: jenisKelaminCon.value,
      tanggalLahir: tanggalLahirCon.value,
      alamat: alamatCon.value,
      cabangs: selectCabangCon.values
          .map(
            (e) => SalonCabangModel(
              id: e.value,
              idSalon: localDataSource.salonData.id,
              nama: e.title,
              alamat: "",
              phone: e.subtitle ?? "",
            ),
          )
          .toList(),
    );

    await handleRequest(
      showLoading: false,
      () => _repository.updateStaffById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
        userModelToJson(model),
      ),
      onSuccess: (res) {
        localDataSource.userData.level == 1
            ? isEditable(true)
            : isEditable(false);
        itemId = res.id;
        Get.back();
      },
      showErrorSnackbar: false,
    );
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (namaCon.value != null ||
            emailCon.value != null ||
            phoneCon.value != null ||
            nikCon.value != null ||
            jenisKelaminCon.value != null ||
            tanggalLahirCon.value != null ||
            alamatCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }

  void setupSelectMultipleController() {
    Future<Success<List<SelectItemModel>>> getCabangByIdSalon(
      int pageIndex,
    ) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        showLoading: false,
        () => _salonRepository.getCabangByIdSalon(
          idSalon: localDataSource.salonData.id,
          pageIndex: pageIndex,
          pageSize: 10,
          keyword: selectCabangCon.keyword,
        ),
        onSuccess: (res) {
          returnData = Success(
            res.data
                .map(
                  (e) => SelectItemModel(
                    value: e.id,
                    title: e.nama,
                    subtitle: e.phone,
                  ),
                )
                .toList(),
            meta: res.meta,
            message: res.message,
          );
        },
      );
      return returnData;
    }

    final listCon = ListComponentController(
      getDataResult: getCabangByIdSalon,
      fromDynamic: SalonCabangModel.fromDynamic,
    );
    selectCabangCon = SelectMultipleController(
      listController: listCon,
      onChanged: (items) => update(),
    );
  }
}
