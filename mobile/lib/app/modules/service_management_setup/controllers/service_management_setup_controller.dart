import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/custom_multiple_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/components/others/select_single_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/client_model.dart';
import 'package:salonku/app/models/payment_method_model.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/select_item_model.dart';
import 'package:salonku/app/models/service_model.dart';
import 'package:salonku/app/models/widget_service_model.dart';

class ServiceManagementSetupController extends SetupBaseController {
  final catatanCon = InputTextController(type: InputTextType.paragraf);
  late final SelectSingleController selectClientCon;
  late final SelectSingleController selectPaymentCon;
  late final SelectMultipleController selectServicesCon;
  final showCustomServiceCon = InputRadioController(
    items: [
      RadioButtonItem(text: "yes".tr, value: true),
      RadioButtonItem(text: "no".tr, value: false),
    ],
  );
  RxBool customService = false.obs;
  late final SelectSingleController selectCabangCon;

  late final CustomMultipleController<WidgetServiceModel> customServicesCon;

  double totalServices = 0.0;
  double totalCustomService = 0.0;
  RxDouble grandTotal = 0.0.obs;

  final ClientRepositoryContract _clientRepository;
  final PaymentMethodRepositoryContract _paymentMethodRepository;
  final ServiceRepositoryContract _serviceRepository;
  final SalonRepositoryContract _salonRepository = Get.find();
  final LocalDataSource _localDataSource = Get.find();
  ServiceManagementSetupController(
    this._clientRepository,
    this._paymentMethodRepository,
    this._serviceRepository,
  );

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  PaymentMethodModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
    showCustomServiceCon.value = false;
    showCustomServiceCon.onChanged = (v) => customService(v.value);
    _initSelectComponents();
    customServicesCon = CustomMultipleController(
      mapper: (model) => SelectItemModel(
        title: model.namaService,
        value: model.id,
        subtitle: "$currencyCode ${InputFormatter.toCurrency(model.harga)}",
      ),
      createChildren: () async {
        final namaServiceCon = InputTextController();
        final deskripsiCon = InputTextController(type: InputTextType.paragraf);
        final hargaCon = InputTextController(type: InputTextType.money);
        var r = await ReusableWidgets.fullScreenBottomSheet(
          title: "select_data".tr,
          children: [
            InputTextComponent(
              label: "nama_service".tr,
              placeHolder: "placeholder_nama_service".tr,
              controller: namaServiceCon,
              required: true,
            ),
            InputTextComponent(
              label: "deskripsi".tr,
              placeHolder: "placeholder_deskripsi".tr,
              controller: deskripsiCon,
            ),
            InputTextComponent(
              label: "harga".tr,
              placeHolder: "placeholder_harga".tr,
              controller: hargaCon,
              prefixText: currencyCode,
              required: true,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Expanded(
                  child: ButtonComponent(
                    text: "cancel".tr,
                    isMultilineText: true,
                    borderColor: Get.context?.contrast,
                    buttonColor: Get.context?.accent,
                    textColor: Get.context?.text,
                    borderRadius: Radiuses.regular,
                    onTap: () {
                      Get.back(result: false);
                    },
                  ),
                ),
                Expanded(
                  child: ButtonComponent(
                    text: "ok".tr,
                    borderRadius: Radiuses.regular,
                    isMultilineText: true,
                    onTap: () {
                      if (!namaServiceCon.isValid) return;
                      if (!hargaCon.isValid) return;
                      Get.back(result: true);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
        if (r == true) {
          return WidgetServiceModel(
            id: 0,
            idServiceManagement: 0,
            namaService: namaServiceCon.value,
            deskripsi: deskripsiCon.value,
            harga: hargaCon.value,
          );
        } else {
          return null;
        }
      },
    );
    customServicesCon.onChanged = (items) {
      totalCustomService = items.fold(0.0, (sum, item) => sum + item.harga);
      grandTotal(totalServices + totalCustomService);
    };
  }

  void addValueInputFields(PaymentMethodModel? model) {
    if (model != null) {
      // paymentMethodCon.value = model.nama;
      // codeCon.value = model.kode;
    }
  }

  Future<void> getById() async {
    // await handleRequest(
    //   showLoading: true,
    //   () => _repository.getPaymentMethodById(
    //     InputFormatter.dynamicToInt(itemId) ?? 0,
    //   ),
    //   onSuccess: (res) {
    //     model = res;
    //     addValueInputFields(res);
    //   },
    //   showErrorSnackbar: false,
    // );
  }

  Future<void> saveOnTap() async {
    // if (!catatanCon.isValid) return;
    // if (!selectClientCon.isValid) return;
    // if (!selectPaymentCon.isValid) return;
    // if (!selectServicesCon.isValid) return;
    // if (!selectCabangCon.isValid) return;

    print(customServicesCon.values.last.namaService);

    // final model = PaymentMethodModel(
    //   id: 0,
    //   idSalon: _localDataSource.salonData.id,
    //   nama: paymentMethodCon.value,
    //   kode: codeCon.value,
    // );

    // await handleRequest(
    //   showLoading: false,
    //   () => itemId == null
    //       ? _repository.createPaymentMethod(paymentMethodModelToJson(model))
    //       : _repository.updatePaymentMethodById(
    //           InputFormatter.dynamicToInt(itemId) ?? 0,
    //           paymentMethodModelToJson(model),
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
        (selectPaymentCon.value != null || selectCabangCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }

  void _initSelectComponents() {
    setupSelectClientController();
    setupSelectPaymentController();
    setupSelectServiceController();
    setupSelectCabangController();
  }

  //select single
  void setupSelectClientController() {
    Future<Success<List<SelectItemModel>>> getListData(int pageIndex) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        () => _clientRepository.getClientByIdSalon(
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
      getDataResult: getListData,
      fromDynamic: ClientModel.fromDynamic,
    );
    selectClientCon = SelectSingleController(listController: listCon);
  }

  void setupSelectPaymentController() {
    Future<Success<List<SelectItemModel>>> getListData(int pageIndex) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        () => _paymentMethodRepository.getPaymentMethodByIdSalon(
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
                    subtitle: e.kode,
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
      getDataResult: getListData,
      fromDynamic: PaymentMethodModel.fromDynamic,
    );
    selectPaymentCon = SelectSingleController(listController: listCon);
  }

  void setupSelectCabangController() {
    Future<Success<List<SelectItemModel>>> getListData(int pageIndex) async {
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
      getDataResult: getListData,
      fromDynamic: SalonCabangModel.fromDynamic,
    );
    selectCabangCon = SelectSingleController(listController: listCon);
  }

  //select multiple
  void setupSelectServiceController() {
    Future<Success<List<SelectItemModel>>> getListData(int pageIndex) async {
      Success<List<SelectItemModel>> returnData = Success([]);
      await handlePaginationRequest(
        () => _serviceRepository.getServiceList(
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
                    addedValue: e.harga,
                    title: e.nama,
                    subtitle:
                        "$currencyCode ${InputFormatter.toCurrency(e.harga)}",
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
      getDataResult: getListData,
      fromDynamic: ServiceModel.fromDynamic,
    );
    selectServicesCon = SelectMultipleController(listController: listCon);
    selectServicesCon.onChanged = (items) {
      totalServices = items.fold(
        0.0,
        (sum, item) => sum + (item.addedValue as num).toDouble(),
      );
      grandTotal(totalServices + totalCustomService);
    };
  }
}
