import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
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
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: controller.cancelEditOnTap,
      ),
    );
  }
}
