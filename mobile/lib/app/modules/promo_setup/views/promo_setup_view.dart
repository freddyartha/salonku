import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
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
          InputTextComponent(
            label: "potongan_harga".tr,
            placeHolder: "placeholder_potongan_harga".tr,
            controller: controller.potonganHargaCon,
            editable: controller.isEditable.value,
          ),
          InputTextComponent(
            label: "potongan_persen".tr,
            placeHolder: "placeholder_potongan_persen".tr,
            controller: controller.potonganPersenCon,
            editable: controller.isEditable.value,
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
