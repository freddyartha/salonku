import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.instance;
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeController.themeMode.value == ThemeMode.dark
                        ? AppColors.darkAccent
                        : AppColors.lightAccent,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.only(bottom: 20),
                child: ImageComponent(
                  localUrl: "assets/images/png/error_image.png",
                  height: 100,
                  width: 100,
                  boxFit: BoxFit.cover,
                ),
              ),
              TextComponent(
                value: "Nama Karyawan",
                fontWeight: FontWeights.semiBold,
                fontSize: FontSizes.h5,
                textAlign: TextAlign.center,
              ),
              TextComponent(
                value: "email@email.com",
                textAlign: TextAlign.center,
              ),
              Center(
                child: ButtonComponent(
                  onTap: () {},
                  text: "Edit Profile",
                  width: Get.width / 2,
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  borderRadius: Radiuses.large,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Radiuses.large),
                  color: themeController.themeMode.value == ThemeMode.dark
                      ? AppColors.darkAccent
                      : AppColors.lightAccent,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: controller.menuItemList.length,
                  itemBuilder: (context, index) {
                    var item = controller.menuItemList[index];
                    return ListTile(
                      onTap: item.onTab,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      trailing: Icon(Icons.chevron_right_rounded),
                      title: TextComponent(value: item.title),
                      leading: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              themeController.themeMode.value == ThemeMode.dark
                              ? AppColors.darkAccent2
                              : AppColors.lightAccent2,
                        ),
                        child: ImageComponent(
                          localUrl: item.id == 1
                              ? themeController.themeMode.value ==
                                        ThemeMode.dark
                                    ? "assets/images/png/dark_mode.png"
                                    : "assets/images/png/light_mode.png"
                              : item.imageLocation,
                          height: 25,
                          width: 25,
                          color:
                              themeController.themeMode.value == ThemeMode.dark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
