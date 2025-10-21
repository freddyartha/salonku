import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: controller.authCon.signOut,
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.chevron_left_rounded,
                              color: context.text,
                            ),
                            TextComponent(value: "back".tr),
                          ],
                        ),
                      ),
                    ),
                    TextComponent(
                      margin: EdgeInsetsGeometry.only(top: 20),
                      value:
                          "Anda belum terdaftar dalam sistem, daftarkan data anda terlebih dahulu",
                      textAlign: TextAlign.center,
                    ),
                    TextComponent(
                      margin: EdgeInsetsGeometry.only(top: 35, bottom: 15),
                      value: "Pilih mendaftar sebagai",
                      textAlign: TextAlign.center,
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      physics: NeverScrollableScrollPhysics(),
                      children: controller.registerTypeList
                          .map(
                            (item) => GestureDetector(
                              onTap: item.onTab,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: context.accent2,
                                  borderRadius: BorderRadius.circular(
                                    Radiuses.extraLarge,
                                  ),

                                  border: Border.all(color: context.contrast),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    ImageComponent(
                                      localUrl: item.imageLocation,
                                      height: Get.width * 0.15,
                                      width: Get.width * 0.15,
                                      color: context.text,
                                    ),
                                    TextComponent(
                                      value: item.title?.tr,
                                      fontWeight: FontWeights.semiBold,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
