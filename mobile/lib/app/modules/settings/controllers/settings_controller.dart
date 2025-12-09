import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/salon_repository_contract.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/menu_item_model.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/models/salon_summary_model.dart';
import 'package:salonku/app/models/user_model.dart';
import 'package:salonku/app/routes/app_pages.dart';

class SettingsController extends BaseController {
  final SalonRepositoryContract _salonRepositoryContract = Get.find();
  final LocalDataSource _localDataSource = Get.find();

  final InputTextController namaSalonCon = InputTextController();
  final InputTextController alamatSalonCon = InputTextController(
    type: InputTextType.paragraf,
  );
  final InputPhoneController phoneSalonCon = InputPhoneController();
  final InputTextController currencyCon = InputTextController(
    type: InputTextType.text,
  );

  final RxList<MenuItemModel> salonSummaryList = <MenuItemModel>[].obs;
  final List<MenuItemModel> dataUtamaList = [];
  late final UserModel userData;
  late Rx<SalonModel> salonModel = _localDataSource.salonData.obs;

  @override
  void onInit() {
    userData = _localDataSource.userData;

    dataUtamaList.addAll([
      MenuItemModel(
        title: "service",
        imageLocation: "assets/images/png/services.png",
        onTab: () => Get.toNamed(
          Routes.SERVICE_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      if (userData.level != 3)
        MenuItemModel(
          title: "promo",
          imageLocation: "assets/images/png/promos.png",
          onTab: () => Get.toNamed(
            Routes.PROMO_LIST,
            arguments: {"idSalon": "${userData.idSalon}"},
          ),
        ),
      MenuItemModel(
        title: "product",
        imageLocation: "assets/images/png/products.png",
        onTab: () => Get.toNamed(
          Routes.PRODUCT_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      MenuItemModel(
        title: "supplier",
        imageLocation: "assets/images/png/supplier.png",
        onTab: () => Get.toNamed(
          Routes.SUPPLIER_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
    ]);
    if (!ReusableStatics.userIsStaff(userData)) {
      dataUtamaList.add(
        MenuItemModel(
          title: "metode_pembayaran",
          imageLocation: "assets/images/png/payment_method.png",
          onTab: () => Get.toNamed(
            Routes.PAYMENT_METHOD_LIST,
            arguments: {"idSalon": "${userData.idSalon}"},
          ),
        ),
      );
    }

    super.onInit();
  }

  Future<void> getSalonSummary() async {
    if (!ReusableStatics.userIsStaff(userData)) {
      _initSalonSummaryDatas(null);
      await handleRequest(
        showEasyLoading: false,
        () => _salonRepositoryContract.getSalonSummary(userData.idSalon ?? 0),
        onSuccess: (res) {
          _initSalonSummaryDatas(res);
        },
        showErrorSnackbar: false,
      );
    }
  }

  void _initSalonSummaryDatas(SalonSummaryModel? item) {
    salonSummaryList.clear();
    salonSummaryList.addAll([
      MenuItemModel(
        title: "jumlah_cabang",
        value: item?.jumlahCabang.toString(),
        onTab: () => Get.toNamed(
          Routes.SALON_CABANG_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
      MenuItemModel(
        title: "jumlah_staff",
        value: item?.jumlahStaff.toString(),
        onTab: () => Get.toNamed(
          Routes.STAFF_LIST,
          arguments: {"idSalon": "${userData.idSalon}"},
        ),
      ),
    ]);
  }

  Future<void> showEditSalon() async {
    namaSalonCon.value = salonModel.value.namaSalon;
    alamatSalonCon.value = salonModel.value.alamat;
    phoneSalonCon.value = salonModel.value.phone;
    currencyCon.value = salonModel.value.currencyCode;

    currencyCon.onTap = () => showCurrencyPicker(
      context: Get.context!,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      favorite: ["IDR", "USD"],
      onSelect: (Currency currency) => currencyCon.value = currency.code,
      theme: ReusableStatics.currencyPickerTheme(),
    );

    await ReusableWidgets.fullScreenBottomSheet(
      children: [
        InputTextComponent(
          controller: namaSalonCon,
          label: "nama_salon".tr,
          placeHolder: "placeholder_nama_salon".tr,
          required: true,
        ),
        InputTextComponent(
          controller: alamatSalonCon,
          label: "alamat_salon".tr,
          placeHolder: "placeholder_alamat_salon".tr,
          required: true,
        ),
        InputPhoneComponent(
          controller: phoneSalonCon,
          label: "nomor_telp_salon".tr,
          required: true,
        ),
        InputTextComponent(
          marginBottom: 30,
          controller: currencyCon,
          label: "currency".tr,
          placeHolder: "currency_hint".tr,
          required: true,
          editable: true,
          disableInputKeyboard: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(Icons.arrow_drop_down_outlined, size: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Expanded(
              child: ButtonComponent(
                text: "cancel".tr,
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
                text: "save".tr,
                borderRadius: Radiuses.regular,
                buttonColor: Get.context?.contrast,
                onTap: () => _updateSalon(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _updateSalon() async {
    if (!namaSalonCon.isValid) return;
    if (!alamatSalonCon.isValid) return;
    if (!phoneSalonCon.isValid) return;
    if (!currencyCon.isValid) return;

    final model = SalonModel(
      id: 0,
      namaSalon: namaSalonCon.value,
      kodeSalon: "",
      currencyCode: currencyCon.value,
      alamat: alamatSalonCon.value,
      phone: phoneSalonCon.value,
    );

    await handleRequest(
      () => _salonRepositoryContract.updateSalon(
        salonModel.value.id,
        salonModelToJson(model),
      ),
      onSuccess: (res) async {
        _localDataSource.cacheSalon(res);
        salonModel(res);
        Get.back();
      },
      showErrorSnackbar: true,
    );
  }
}
