import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/promo_repository_contract.dart';
import 'package:salonku/app/models/promo_model.dart';

class PromoSetupController extends SetupBaseController {
  final namaCon = InputTextController();
  final deskripsiCon = InputTextController(type: InputTextType.paragraf);
  final potonganHargaCon = InputTextController(type: InputTextType.money);
  final potonganPersenCon = InputTextController(type: InputTextType.number);
  final berlakuCon = InputDatetimeController(type: InputDatetimeType.dateRange);
  final selectJenisPromoCon = InputRadioController(
    items: [
      RadioButtonItem(text: "potongan_persen".tr, value: 1),
      RadioButtonItem(text: "potongan_harga".tr, value: 2),
    ],
  );
  RxInt selectedJenisPromo = 0.obs;

  final LocalDataSource _localDataSource = Get.find();
  final PromoRepositoryContract _repository;
  PromoSetupController(this._repository);

  PromoModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
    selectJenisPromoCon.onChanged = (v) => selectedJenisPromo(v.value);
  }

  void addValueInputFields(PromoModel? model) {
    if (model != null) {
      namaCon.value = model.nama;
      deskripsiCon.value = model.deskripsi;
      if (model.potonganPersen != null) {
        selectJenisPromoCon.value = 1;
        selectedJenisPromo(1);
        potonganPersenCon.value = model.potonganPersen;
      }
      if (model.potonganHarga != null) {
        selectJenisPromoCon.value = 2;
        selectedJenisPromo(2);
        potonganHargaCon.value = model.potonganHarga;
      }
      berlakuCon.value = DateTimeRange(
        start: model.berlakuMulai,
        end: model.berlakuSampai,
      );
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _repository.getPromoById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaCon.isValid) return;
    if (!deskripsiCon.isValid) return;
    if (!selectJenisPromoCon.isValid) return;
    if (!potonganPersenCon.isValid) return;
    if (!potonganHargaCon.isValid) return;
    if (!berlakuCon.isValid) return;

    if (potonganHargaCon.value == null && potonganPersenCon.value == null) {
      ReusableWidgets.notifBottomSheet(
        subtitle:
            "salah satu dari potongan harga atau potongan persen wajib diisi",
      );
      return;
    }

    final model = PromoModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      currencyCode: "",
      nama: namaCon.value,
      deskripsi: deskripsiCon.value,
      potonganHarga: potonganHargaCon.value,
      potonganPersen: InputFormatter.dynamicToDouble(potonganPersenCon.value),
      berlakuMulai: berlakuCon.value.start,
      berlakuSampai: berlakuCon.value.end,
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _repository.createPromo(promoModelToJson(model))
          : _repository.updatePromoById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              promoModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        addValueInputFields(res);
      },
    );
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (namaCon.value != null ||
            namaCon.value != null ||
            berlakuCon.value != null ||
            deskripsiCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }
}
