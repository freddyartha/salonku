import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 80),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.accent),
                ),
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.only(bottom: 20),
                child: ImageComponent(
                  networkUrl: controller.salonModel?.logoUrl ?? "",
                  height: 100,
                  width: 100,
                  boxFit: BoxFit.contain,
                ),
              ),
              TextComponent(
                value: controller.salonModel?.namaSalon,
                isLoading: controller.isLoading.value,
                fontWeight: FontWeights.semiBold,
                fontSize: FontSizes.h5,
                textAlign: TextAlign.center,
              ),
              TextComponent(
                value: controller.salonModel?.alamat,
                isLoading: controller.isLoading.value,
                textAlign: TextAlign.center,
              ),
              if (!controller.isLoading.value) ...[
                Center(
                  child: ButtonComponent(
                    onTap: () {},
                    text: "Edit Salon",
                    width: Get.width / 2,
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    borderRadius: Radiuses.large,
                  ),
                ),
              ],
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Radiuses.large),
                  color: context.accent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      value: "Informasi Salon".tr,
                      fontWeight: FontWeights.semiBold,
                      margin: EdgeInsetsGeometry.only(bottom: 10),
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      physics: NeverScrollableScrollPhysics(),
                      children: controller.salonSummaryList
                          .map(
                            (item) => GestureDetector(
                              onTap: item.onTab,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: context.accent2,
                                      borderRadius: BorderRadius.circular(
                                        Radiuses.large,
                                      ),
                                      border: Border.all(
                                        color: context.contrast,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextComponent(
                                        value: item.title?.tr,
                                        textAlign: TextAlign.right,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: Get.width / 6.5,
                                    height: Get.width / 6.5,
                                    decoration: BoxDecoration(
                                      color: context.contrast,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                          Radiuses.extraLarge,
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: TextComponent(
                                        value: item.value,
                                        fontColor: AppColors.darkText,
                                        fontSize: 45,
                                        fontWeight: FontWeights.bold,
                                        textAlign: TextAlign.center,
                                        height: 0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Radiuses.large),
                  color: context.accent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      value: "Data Utama".tr,
                      fontWeight: FontWeights.semiBold,
                      margin: EdgeInsetsGeometry.only(bottom: 10),
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      physics: NeverScrollableScrollPhysics(),
                      children: controller.dataUtamaList
                          .map(
                            (item) => GestureDetector(
                              onTap: item.onTab,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: context.accent2,
                                      borderRadius: BorderRadius.circular(
                                        Radiuses.large,
                                      ),
                                      border: Border.all(
                                        color: context.contrast,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextComponent(
                                        value: item.title?.tr,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeights.semiBold,
                                        fontSize: FontSizes.small,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: Get.width / 5.5,
                                    height: Get.width / 5.5,
                                    decoration: BoxDecoration(
                                      color: context.contrast,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                          Radiuses.extraLarge,
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: ImageComponent(
                                        localUrl: item.imageLocation ?? "",
                                        color: AppColors.darkText,
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
