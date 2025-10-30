import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/supplier_setup_controller.dart';

class SupplierSetupView extends GetView<SupplierSetupController> {
  const SupplierSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "supplier".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "nama_supplier".tr,
            placeHolder: "placeholder_nama_supplierd".tr,
            controller: controller.namaSupplierCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "alamat_supplier".tr,
            placeHolder: "placeholder_alamat_supplier".tr,
            controller: controller.alamatSupplierCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputPhoneComponent(
            controller: controller.phoneSupplierCon,
            label: "nomor_telp_supplier".tr,
            required: true,
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
