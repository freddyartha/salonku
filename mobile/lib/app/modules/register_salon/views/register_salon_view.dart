import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart'
    show InputTextComponent;
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/register_salon_controller.dart';

class RegisterSalonView extends GetView<RegisterSalonController> {
  const RegisterSalonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(height: Get.height, color: context.accent),
          Container(
            color: context.contrast,
            height: (Get.height * 0.3) + 35,
            child: SafeArea(
              child: Center(
                child: ImageComponent(
                  localUrl: "assets/images/png/bell.png",
                  height: 100,
                  width: 100,
                  color: AppColors.darkText,
                ),
              ),
            ),
          ),
          Obx(
            () => ListView(
              padding: EdgeInsets.only(top: (Get.height * 0.3)),
              physics: ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Radiuses.extraLarge),
                      topRight: Radius.circular(Radiuses.extraLarge),
                    ),
                    color: context.accent,
                  ),
                  child: controller.selectedLevel.value == 1
                      ? OwnerWidget(controller: controller)
                      : StaffWidget(controller: controller),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StaffWidget extends StatelessWidget {
  const StaffWidget({super.key, required this.controller});

  final RegisterSalonController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.selectedLevel(0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.chevron_left_rounded),
                TextComponent(value: "Kembali"),
              ],
            ),
          ),
        ),
        TextComponent(
          margin: EdgeInsets.symmetric(vertical: 20),
          value: "Masukkan Kode Unik Salon Tempat Kamu Bekerja*",
          textAlign: TextAlign.center,
          fontSize: FontSizes.h5,
          fontWeight: FontWeights.semiBold,
        ),

        Row(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: InputTextComponent(
                controller: controller.nikOwnerCon,
                placeHolder: "Kode Unik Salon",
                required: true,
                marginBottom: 0,
              ),
            ),
            Expanded(
              flex: 1,
              child: ButtonComponent(onTap: () {}, text: "Cari"),
            ),
          ],
        ),
        TextComponent(
          value:
              "*Kode Unik Salon bisa ditemukan di halaman profil dari aplikasi SalonKu yang dimiliki Owner Salon",
          fontSize: FontSizes.small,
          margin: EdgeInsets.only(top: 20),
        ),
      ],
    );
  }
}

class OwnerWidget extends StatelessWidget {
  const OwnerWidget({super.key, required this.controller});

  final RegisterSalonController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextComponent(
          margin: EdgeInsetsGeometry.symmetric(vertical: 20),
          value: "Tambahkan Data Salon Kamu Dulu",
          textAlign: TextAlign.center,
          fontSize: FontSizes.h5,
          fontWeight: FontWeights.semiBold,
        ),
        InputTextComponent(
          controller: controller.namaSalonCon,
          label: "Nama Salon",
          required: true,
        ),
        InputTextComponent(
          controller: controller.alamatSalonCon,
          label: "Alamat Salon",
          required: true,
        ),
        InputTextComponent(
          controller: controller.telpSalonCon,
          label: "No Telp. Salon",
          required: true,
          marginBottom: 30,
        ),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: ButtonComponent(
                onTap: () => controller.selectedLevel.value = 0,
                text: "Batal",
                borderColor: context.contrast,
                buttonColor: context.accent2,
              ),
            ),
            Expanded(
              child: ButtonComponent(
                onTap: controller.createSalon,
                text: "Simpan",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
