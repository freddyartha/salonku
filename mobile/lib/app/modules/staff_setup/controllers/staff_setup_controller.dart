import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/others/select_single_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/staff_repository_contract.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/select_item_model.dart';
import 'package:salonku/app/models/user_model.dart';

class StaffSetupController extends SetupBaseController {
  final approvedDate = InputDatetimeController();
  final namaCon = InputTextController();
  final emailCon = InputTextController(type: InputTextType.email);
  final phoneCon = InputPhoneController();
  final nikCon = InputTextController();
  final jenisKelaminCon = InputRadioController(
    items: ReusableStatics.jenisKelaminRadioItem,
  );
  final tanggalLahirCon = InputDatetimeController();
  final alamatCon = InputTextController(type: InputTextType.paragraf);

  final LocalDataSource _localDataSource = Get.find();
  final SalonRepositoryContract _salonRepository = Get.find();
  final StaffRepositoryContract _repository;
  StaffSetupController(this._repository);

  UserModel? model;

  late final SelectSingleController selectCabangCon;

  @override
  void onInit() {
    super.onInit();
    setupSelectCabangController();
    if (itemId != null) {
      getById();
    }
  }

  void addValueInputFields(UserModel? model) {
    if (model != null) {
      namaCon.value = model.nama;
      emailCon.value = model.email;
      phoneCon.value = model.phone;
      nikCon.value = model.nik;
      jenisKelaminCon.value = model.jenisKelamin;
      approvedDate.value = model.approvedDate;
      tanggalLahirCon.value = model.tanggalLahir;
      alamatCon.value = model.alamat;

      if (model.cabangs != null && model.cabangs!.isNotEmpty) {
        selectCabangCon.value = SelectItemModel(
          title: model.cabangs!.first.nama,
          subtitle: model.cabangs!.first.phone,
          value: model.cabangs!.first.id,
        );
      }
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _repository.getStaffById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
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

    // final model = UserModel(
    // id: 0,
    // idSalon: _localDataSource.salonData.id,
    // idSupplier: selectSupplierCon.value?.value,
    // brand: brandCon.value,
    // nama: namaCon.value,
    // satuan: satuanCon.value,
    // ukuran: ukuranCon.value,
    // hargaSatuan: hargaSatuanCon.value,
    // currencyCode: "",
    // );

    // await handleRequest(
    //   showLoading: false,
    //   () => _repository.updateStaffById(
    //           InputFormatter.dynamicToInt(itemId) ?? 0,
    //           userModelToJson(model),
    //         ),
    //   onSuccess: (res) {
    //     isEditable(false);
    //     itemId = res.id;
    //     addValueInputFields(res);
    //   },
    //   showErrorSnackbar: false,
    // );
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

  void setupSelectCabangController() {
    Future<Success<List<SelectItemModel>>> getCabangByIdSalon(
      int pageIndex,
    ) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        () => _salonRepository.getCabangByIdSalon(
          idSalon: _localDataSource.salonData.id,
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
    selectCabangCon = SelectSingleController(listController: listCon);
  }
}
