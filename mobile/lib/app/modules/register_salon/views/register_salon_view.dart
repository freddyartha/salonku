import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
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
          ListView(
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
                child: controller.level == 1
                    ? OwnerWidget(controller: controller)
                    : StaffWidget(controller: controller),
              ),
            ],
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
    return GetBuilder<RegisterSalonController>(
      builder: (controller) {
        return Column(
          children: [
            if (controller.salonByKode == null) ...[
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
                      controller: controller.kodeSalonCon,
                      placeHolder: "Kode Unik Salon",
                      required: true,
                      marginBottom: 0,
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: ButtonComponent(
                      onTap: controller.getSalonByUniqueId,
                      text: "Cari",
                    ),
                  ),
                ],
              ),
              if (!controller.isSalonFound.value) ...[
                Column(
                  children: [
                    ImageComponent(
                      localUrl: "assets/images/png/settings.png",
                      height: 150,
                      width: Get.width,
                      boxFit: BoxFit.fitHeight,
                      margin: EdgeInsets.zero,
                    ),
                    TextComponent(
                      value: "Kode Unik Salon yang anda cari tidak ditemukan",
                    ),
                  ],
                ),
              ],
              TextComponent(
                value:
                    "*Kode Unik Salon bisa ditemukan di halaman profil dari aplikasi SalonKu yang dimiliki Owner Salon",
                fontSize: FontSizes.small,
                margin: EdgeInsets.only(top: 20),
              ),
            ],

            if (controller.salonByKode != null) ...[
              TextComponent(
                margin: EdgeInsets.symmetric(vertical: 20),
                value: "Salon Berhasil Ditemukan!",
                textAlign: TextAlign.center,
                fontSize: FontSizes.h5,
                fontWeight: FontWeights.semiBold,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Radiuses.large),
                  border: BoxBorder.all(color: context.contrast),
                ),
                child: ListTile(
                  title: TextComponent(
                    value: controller.salonByKode?.namaSalon,
                    fontWeight: FontWeights.semiBold,
                    fontSize: FontSizes.h5,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(value: controller.salonByKode?.alamat),
                      TextComponent(value: controller.salonByKode?.phone),
                    ],
                  ),
                  leading: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ImageComponent(
                      networkUrl: controller.salonByKode?.logoUrl ?? "",
                      height: 50,
                      width: 50,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: ButtonComponent(
                      buttonColor: Colors.transparent,
                      borderColor: context.contrast,
                      onTap: controller.clearSalonData,
                      text: "Ulangi Pencarian",
                    ),
                  ),
                  Expanded(
                    child: ButtonComponent(
                      onTap: () => controller.userAddSalon(
                        controller.userId,
                        controller.salonByKode?.id ?? 0,
                      ),
                      text: "Lanjut",
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
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
        ButtonComponent(onTap: controller.createSalon, text: "Simpan"),
      ],
    );
  }
}
