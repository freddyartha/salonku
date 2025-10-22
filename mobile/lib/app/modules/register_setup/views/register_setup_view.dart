import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/register_setup_controller.dart';

class RegisterSetupView extends GetView<RegisterSetupController> {
  const RegisterSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "registrasi_data_diri".tr,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ReusableWidgets.generalBottomDecoration(),

            ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  margin: EdgeInsets.only(bottom: 10),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: context.accent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Get.width / 2),
                      bottomRight: Radius.circular(Get.width / 2),
                    ),
                  ),
                  child: Center(
                    child: TextComponent(
                      value: "isi_data_diri_dulu".tr,
                      textAlign: TextAlign.center,
                      fontSize: FontSizes.h6,
                      fontWeight: FontWeights.semiBold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InputTextComponent(
                        label: "nama".tr,
                        controller: controller.namaCon,
                        placeHolder: "placeholder_nama".tr,
                        required: true,
                      ),
                      InputPhoneComponent(
                        controller: controller.phoneCon,
                        label: "nomor_hp".tr,
                        required: true,
                      ),
                      InputTextComponent(
                        label: "nomor_id_card".tr,
                        controller: controller.nikCon,
                        placeHolder: "placeholder_nomor_id_card".tr,
                        required: true,
                      ),
                      InputRadioComponent(
                        controller: controller.jenisKelaminCon,
                        label: "pilih_jenis_kelamin".tr,
                        required: true,
                      ),
                      InputDatetimeComponent(
                        label: "tanggal_lahir".tr,
                        controller: controller.tanggalLahirCon,
                        placeHolder: "placeholder_tanggal_lahir".tr,
                        required: true,
                      ),
                      InputTextComponent(
                        label: "alamat".tr,
                        controller: controller.alamatCon,
                        placeHolder: "placeholder_alamat".tr,
                        required: true,
                      ),
                      ButtonComponent(
                        margin: EdgeInsets.only(top: 30),
                        onTap: controller.registerUser,
                        text: "save".tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
