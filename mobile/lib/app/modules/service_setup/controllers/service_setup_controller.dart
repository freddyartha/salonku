import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/service_model.dart';

class ServiceSetupController extends SetupBaseController {
  final namaServiceCon = InputTextController();
  final deskripsiCon = InputTextController(type: InputTextType.paragraf);
  final hargaCon = InputTextController(type: InputTextType.money);
  final cabangSpesifikCon = InputRadioController(
    items: [
      RadioButtonItem(text: "all_branch".tr, value: false),
      RadioButtonItem(text: "spesific_branch".tr, value: true),
    ],
  );

  final SalonRepositoryContract _salonRepositoryContract;
  final ServiceRepositoryContract _serviceRepositoryContract;
  final LocalDataSource _localDataSource;
  ServiceSetupController(
    this._salonRepositoryContract,
    this._serviceRepositoryContract,
    this._localDataSource,
  );

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  ServiceModel? model;

  late final SelectMultipleController selectCabangCon;
  RxBool showSelectCabang = false.obs;

  @override
  void onInit() {
    super.onInit();
    setupSelectMultipleController();
    if (itemId != null) {
      getServiceById();
    }
    cabangSpesifikCon.value = false;
    cabangSpesifikCon.onChanged = (v) {
      showSelectCabang(v.value);
    };
  }

  void _addValueInputFields(ServiceModel model) {
    namaServiceCon.value = model.nama;
    deskripsiCon.value = model.deskripsi;
    hargaCon.value = model.harga;
    if (model.cabang != null && model.cabang!.isNotEmpty) {
      selectCabangCon.values = model.cabang!
          .map(
            (e) =>
                SelectItemModel(title: e.nama, subtitle: e.phone, value: e.id),
          )
          .toList();
    }
  }

  Future<void> getServiceById() async {
    await handleRequest(
      showLoading: true,
      () => _serviceRepositoryContract.getServiceById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
      ),
      onSuccess: (res) {
        model = res;
        _addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaServiceCon.isValid) return;
    if (!deskripsiCon.isValid) return;
    if (!hargaCon.isValid) return;
    if (!selectCabangCon.isValid) return;

    final model = ServiceModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      nama: namaServiceCon.value,
      deskripsi: deskripsiCon.value,
      harga: hargaCon.value,
      currencyCode: "",
      cabang: selectCabangCon.values
          .map(
            (e) => ServiceCabangModel(
              id: e.value,
              nama: e.title,
              alamat: "",
              phone: e.subtitle ?? "",
            ),
          )
          .toList(),
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _serviceRepositoryContract.createService(serviceModelToJson(model))
          : _serviceRepositoryContract.updateService(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              serviceModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        _addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  void cancelEditOnTap() {
    namaServiceCon.value = model?.nama;
    deskripsiCon.value = model?.deskripsi;
    hargaCon.value = model?.harga;
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (namaServiceCon.value != null ||
            deskripsiCon.value != null ||
            hargaCon.value != null)) {
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
        () => _salonRepositoryContract.getCabangByIdSalon(
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
    selectCabangCon = SelectMultipleController(listController: listCon);
  }
}
