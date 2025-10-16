import 'dart:io';

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

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.3),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Radiuses.extraLarge),
                  topRight: Radius.circular(Radiuses.extraLarge),
                ),
                color: context.accent,
              ),
              child: SafeArea(
                top: false,
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.only(top: 20),
                    children: [
                      if (!controller.isRegisterEmail.value) ...[
                        TextComponent(
                          value: "MASUK",
                          fontWeight: FontWeights.bold,
                          fontSize: FontSizes.h4,
                          textAlign: TextAlign.center,
                        ),
                        TextComponent(
                          value:
                              "Masuk dulu untuk menikmati semua fitur-fitur aplikasi SalonKU",
                          textAlign: TextAlign.center,
                          margin: EdgeInsetsGeometry.symmetric(vertical: 20),
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: ButtonComponent(
                                onTap: controller.googleLoginOnPress,
                                buttonColor: context.accent2,
                                text: "Google",
                                icon: "assets/images/png/google.png",
                                fontWeight: FontWeights.semiBold,
                                textColor: context.text,
                                iconSize: 25,
                              ),
                            ),
                            if (Platform.isIOS) ...[
                              Expanded(
                                child: ButtonComponent(
                                  onTap: controller.appleLoginOnPress,
                                  buttonColor: context.isLight
                                      ? AppColors.lightText
                                      : context.accent2,
                                  text: "Apple",
                                  icon: "assets/images/png/apple.png",
                                  fontWeight: FontWeights.semiBold,
                                  textColor: context.isLight
                                      ? AppColors.darkText
                                      : context.text,
                                  iconSize: 25,
                                ),
                              ),
                            ],
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: context.text,
                                  thickness: 1.5,
                                ),
                              ),
                              TextComponent(value: "Atau"),
                              Expanded(
                                child: Divider(
                                  color: context.text,
                                  thickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      InputTextComponent(
                        controller: controller.emailCon,
                        placeHolder: "example@example.com",
                        marginBottom: 20,
                      ),
                      InputTextComponent(
                        controller: controller.passCon,
                        placeHolder: "password",
                        marginBottom: 30,
                      ),
                      if (controller.isRegisterEmail.value) ...[
                        InputTextComponent(
                          controller: controller.confirmPassCon,
                          placeHolder: "password",
                          marginBottom: 30,
                        ),
                        ButtonComponent(
                          onTap: controller.emailRegister,
                          buttonColor: context.contrast,
                          text: "Daftarkan Akun",
                          fontWeight: FontWeights.semiBold,
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                      ],
                      if (!controller.isRegisterEmail.value) ...[
                        ButtonComponent(
                          onTap: controller.emailLogin,
                          buttonColor: context.contrast,
                          text: "Masuk",
                          fontWeight: FontWeights.semiBold,
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                      ],
                      GestureDetector(
                        onTap: controller.isRegisterEmail.toggle,
                        child: Row(
                          children: [
                            TextComponent(
                              value: "Belum punya akun berdasarkan email? ",
                            ),
                            TextComponent(
                              value: "Daftar",
                              fontColor: AppColors.info,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
