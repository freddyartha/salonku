import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/pengeluaran_setup_controller.dart';

class PengeluaranSetupView extends GetView<PengeluaranSetupController> {
  const PengeluaranSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "expense".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "nama_pengeluaran".tr,
            placeHolder: "placeholder_nama_pengeluaran".tr,
            controller: controller.namaPengeluaranCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "deskripsi_pengeluaran".tr,
            placeHolder: "placeholder_deskripsi_pengeluaran".tr,
            controller: controller.deskripsiCon,
            editable: controller.isEditable.value,
          ),
          InputTextComponent(
            label: "jumlah_pengeluaran".tr,
            placeHolder: "placeholder_jumlah_pengeluaran".tr,
            controller: controller.hargaCon,
            editable: controller.isEditable.value,
            prefixText: controller.currencyCode,
            required: true,
          ),
          Visibility(
            visible: !ReusableStatics.userIsStaff(controller.userModel),
            child: InputRadioComponent(
              controller: controller.cabangSpesifikCon,
              label: "service_for_branch".tr,
              required: true,
              editable: controller.isEditable.value,
            ),
          ),
          Visibility(
            visible:
                !ReusableStatics.userIsStaff(controller.userModel) &&
                controller.showSelectCabang.value,
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
