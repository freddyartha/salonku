import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/service_setup_controller.dart';

class ServiceSetupView extends GetView<ServiceSetupController> {
  const ServiceSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "service".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "nama_service".tr,
            placeHolder: "placeholder_nama_service".tr,
            controller: controller.namaServiceCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "deskripsi".tr,
            placeHolder: "placeholder_deskripsi".tr,
            controller: controller.deskripsiCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "harga".tr,
            placeHolder: "placeholder_harga".tr,
            controller: controller.hargaCon,
            editable: controller.isEditable.value,
            prefixText: controller.currencyCode,
            required: true,
          ),
          InputRadioComponent(
            controller: controller.cabangSpesifikCon,
            label: "service_for_branch".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          Visibility(
            visible: controller.showSelectCabang.value,
            child: SelectMultipleComponent(
              controller: controller.selectCabangCon,
              label: "branch".tr,
              required: controller.showSelectCabang.value,
              editable: controller.isEditable.value,
            ),
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
