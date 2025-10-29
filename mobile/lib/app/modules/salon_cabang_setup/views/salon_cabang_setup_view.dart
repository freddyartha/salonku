import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/salon_cabang_setup_controller.dart';

class SalonCabangSetupView extends GetView<SalonCabangSetupController> {
  const SalonCabangSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "branch".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "nama_cabang".tr,
            placeHolder: "placeholder_nama_cabang".tr,
            controller: controller.namaCabangCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "alamat_cabang".tr,
            placeHolder: "placeholder_alamat_cabang".tr,
            controller: controller.alamatCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputPhoneComponent(
            label: "phone_cabang".tr,
            controller: controller.phoneCon,
            editable: controller.isEditable.value,
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: controller.cancelEditOnTap,
      ),
    );
  }
}
