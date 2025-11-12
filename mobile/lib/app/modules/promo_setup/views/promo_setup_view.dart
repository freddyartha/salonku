import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/promo_setup_controller.dart';

class PromoSetupView extends GetView<PromoSetupController> {
  const PromoSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "promo".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "kode_promo".tr,
            placeHolder: "placeholder_kode_promo".tr,
            controller: controller.namaCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "deskripsi_promo".tr,
            placeHolder: "placeholder_deskripsi_promo".tr,
            controller: controller.deskripsiCon,
            editable: controller.isEditable.value,
          ),
          InputRadioComponent(
            controller: controller.selectJenisPromoCon,
            label: "pilih_jenis_promo".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          if (controller.selectedJenisPromo.value == 1)
            InputTextComponent(
              label: "potongan_persen".tr,
              placeHolder: "placeholder_potongan_persen".tr,
              controller: controller.potonganPersenCon,
              editable: controller.isEditable.value,
              required: controller.selectedJenisPromo.value == 1 ? true : false,
            ),
          if (controller.selectedJenisPromo.value == 2)
            InputTextComponent(
              label: "potongan_harga".tr,
              placeHolder: "placeholder_potongan_harga".tr,
              controller: controller.potonganHargaCon,
              editable: controller.isEditable.value,
              required: controller.selectedJenisPromo.value == 2 ? true : false,
            ),
          InputDatetimeComponent(
            label: "masa_berlaku".tr,
            placeHolder: "placeholder_masa_berlaku".tr,
            controller: controller.berlakuCon,
            editable: controller.isEditable.value,
            required: true,
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
