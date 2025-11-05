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
import 'package:salonku/app/data/repositories/contract/service_management_repository_contract.dart';
import 'package:salonku/app/data/repositories/contract/service_repository_contract.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/client_model.dart';
import 'package:salonku/app/models/payment_method_model.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/select_item_model.dart';
import 'package:salonku/app/models/service_item_model.dart';
import 'package:salonku/app/models/service_management_model.dart';
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
  final ServiceManagementRepositoryContract _serviceManagementRepository;
  final SalonRepositoryContract _salonRepository = Get.find();
  final LocalDataSource _localDataSource = Get.find();
  ServiceManagementSetupController(
    this._clientRepository,
    this._paymentMethodRepository,
    this._serviceRepository,
    this._serviceManagementRepository,
  );

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  ServiceManagementModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
    showCustomServiceCon.value = false;
    showCustomServiceCon.onChanged = (v) => customService(v.value);
    _initSelectComponents();
  }

  void addValueInputFields(ServiceManagementModel? model) {
    if (model != null) {
      if (model.cabang != null) {
        selectCabangCon.value = SelectItemModel(
          title: model.cabang!.nama,
          subtitle: model.cabang!.phone,
          value: model.cabang!.id,
        );
      }
      catatanCon.value = model.catatan;
      if (model.client != null) {
        selectClientCon.value = SelectItemModel(
          title: model.client!.nama,
          subtitle: model.client!.phone,
          value: model.client!.id,
        );
      }
      if (model.client != null) {
        selectClientCon.value = SelectItemModel(
          title: model.client!.nama,
          subtitle: model.client!.phone,
          value: model.client!.id,
        );
      }
      if (model.services != null) {
        totalServices = model.services!.fold<double>(
          0.0,
          (sum, service) => sum + service.harga,
        );
        grandTotal(totalServices);
        selectServicesCon.values = model.services!
            .map(
              (e) => SelectItemModel(
                title: e.nama,
                subtitle: "$currencyCode ${InputFormatter.toCurrency(e.harga)}",
                value: e.id,
                addedValue: e.harga,
              ),
            )
            .toList();
      }
      if (model.paymentMethod != null) {
        selectPaymentCon.value = SelectItemModel(
          title: model.paymentMethod!.nama,
          subtitle: model.paymentMethod!.kode,
          value: model.paymentMethod!.id,
        );
      }
      if (model.serviceItems != null && model.serviceItems!.isNotEmpty) {
        showCustomServiceCon.value = true;
        customService(true);
        totalCustomService = model.serviceItems!.fold<double>(
          0.0,
          (sum, item) => sum + item.harga,
        );
        grandTotal.value += totalCustomService;
        customServicesCon.values = model.serviceItems!
            .map(
              (e) => WidgetServiceModel(
                namaService: e.namaService,
                deskripsi: e.deskripsi,
                harga: e.harga,
              ),
            )
            .toList();
      }
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _serviceManagementRepository.getServiceManagementById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
      ),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!selectClientCon.isValid) return;
    if (!selectServicesCon.isValid) return;
    if (!selectPaymentCon.isValid) return;
    if (!showCustomServiceCon.isValid) return;
    if (customService.value) {
      if (!customServicesCon.isValid) return;
    }
    if (!selectCabangCon.isValid) return;
    if (!catatanCon.isValid) return;

    final model = ServiceManagementModel(
      id: 0,
      idClient: selectClientCon.value?.value,
      idPaymentMethod: selectPaymentCon.value?.value,
      idSalon: _localDataSource.salonData.id,
      idCabang: selectCabangCon.value?.value,
      services: selectServicesCon.values
          .map(
            (e) => ServiceModel(
              id: e.value,
              idSalon: 0,
              nama: e.title,
              deskripsi: e.subtitle ?? "",
              harga: 0,
              currencyCode: currencyCode,
            ),
          )
          .toList(),
      serviceItems: customServicesCon.values
          .map(
            (e) => ServiceItemModel(
              id: 0,
              idServiceManagement: 0,
              namaService: e.namaService,
              deskripsi: e.deskripsi,
              harga: e.harga,
            ),
          )
          .toList(),
      catatan: catatanCon.value,
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _serviceManagementRepository.createServiceManagement(
              serviceManagementModelToJson(model),
            )
          : _serviceManagementRepository.updateServiceManagementById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              serviceManagementModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
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
    setupSelectLayananKhusus();
    setupSelectClientController();
    setupSelectPaymentController();
    setupSelectServiceController();
    setupSelectCabangController();
  }

  //select custom
  void setupSelectLayananKhusus() {
    customServicesCon = CustomMultipleController(
      mapper: (model) => SelectItemModel(
        title: model.namaService,
        subtitle: "$currencyCode ${InputFormatter.toCurrency(model.harga)}",
      ),
      createChildren: (item) async {
        final namaServiceCon = InputTextController();
        final deskripsiCon = InputTextController(type: InputTextType.paragraf);
        final hargaCon = InputTextController(type: InputTextType.money);
        if (item != null) {
          namaServiceCon.value = item.namaService;
          deskripsiCon.value = item.deskripsi;
          hargaCon.value = item.harga;
        }
        var r = await ReusableWidgets.fullScreenBottomSheet(
          title: "select_data".tr,
          children: [
            InputTextComponent(
              label: "nama_service".tr,
              placeHolder: "placeholder_nama_service".tr,
              controller: namaServiceCon,
              required: true,
              editable: isEditable.value,
            ),
            InputTextComponent(
              label: "deskripsi".tr,
              placeHolder: "placeholder_deskripsi".tr,
              controller: deskripsiCon,
              editable: isEditable.value,
            ),
            InputTextComponent(
              label: "harga".tr,
              placeHolder: "placeholder_harga".tr,
              controller: hargaCon,
              prefixText: currencyCode,
              editable: isEditable.value,
              required: true,
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: isEditable.value,
              child: Row(
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
            ),
          ],
        );
        if (r == true) {
          if (item != null) {
            item.namaService = namaServiceCon.value;
            item.deskripsi = deskripsiCon.value;
            item.harga = hargaCon.value;
            return null;
          } else {
            return WidgetServiceModel(
              namaService: namaServiceCon.value,
              deskripsi: deskripsiCon.value,
              harga: hargaCon.value,
            );
          }
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
