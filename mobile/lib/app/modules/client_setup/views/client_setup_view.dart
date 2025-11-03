import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/client_setup_controller.dart';

class ClientSetupView extends GetView<ClientSetupController> {
  const ClientSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "client".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "client_name".tr,
            placeHolder: "placeholder_client_name".tr,
            controller: controller.namaCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputPhoneComponent(
            controller: controller.phoneCon,
            label: "nomor_telp_salon".tr,
            required: true,
          ),
          InputTextComponent(
            label: "client_email".tr,
            placeHolder: "placeholder_client_email".tr,
            controller: controller.emailCon,
            editable: controller.isEditable.value,
          ),
          InputRadioComponent(
            controller: controller.jenisKelaminCon,
            label: "pilih_jenis_kelamin".tr,
          ),
          InputTextComponent(
            label: "client_alamat".tr,
            placeHolder: "placeholder_client_alamat".tr,
            controller: controller.alamatCon,
            editable: controller.isEditable.value,
          ),

          Visibility(
            visible: !controller.isEditable.value,
            child: Padding(
              padding: EdgeInsetsGeometry.only(top: 30),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: ButtonComponent(
                      onTap: controller.openWhatsApp,
                      buttonColor: AppColors.success,
                      borderColor: AppColors.success,
                      textColor: AppColors.darkText,
                      isMultilineText: true,
                      text: "",
                      icon: "assets/images/png/whatsapp.png",
                      iconSize: 30,
                      isSvg: false,
                    ),
                  ),
                  Expanded(
                    child: ButtonComponent(
                      textColor: AppColors.darkText,
                      onTap: controller.openEmail,
                      text: "",
                      icon: "assets/images/png/email.png",
                      iconSize: 30,
                      isSvg: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
