import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/controllers/theme_controller.dart';

import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                networkUrl: controller.userModel.avatarUrl,
                height: 100,
                width: 100,
                boxFit: BoxFit.cover,
              ),
            ),
            TextComponent(
              value: controller.userModel.nama,
              fontWeight: FontWeights.semiBold,
              fontSize: FontSizes.h5,
              textAlign: TextAlign.center,
            ),
            TextComponent(
              value: controller.userModel.email,
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
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radiuses.large),
                color: context.accent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //tema
                  TextComponent(
                    value: "change_mode".tr,
                    fontWeight: FontWeights.semiBold,
                    margin: EdgeInsetsGeometry.only(bottom: 5),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: context.contrast),
                      borderRadius: BorderRadius.circular(Radiuses.large),
                    ),
                    child: Row(
                      children: [
                        ThemeItem(
                          imageLocation: "assets/images/png/system.png",
                          itemThemeMode: ThemeMode.system,
                        ),
                        ThemeItem(
                          imageLocation: "assets/images/png/light_mode.png",
                          itemThemeMode: ThemeMode.light,
                        ),
                        ThemeItem(
                          imageLocation: "assets/images/png/dark_mode.png",
                          itemThemeMode: ThemeMode.dark,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  //bahasa
                  TextComponent(
                    value: "change_language".tr,
                    fontWeight: FontWeights.semiBold,
                    margin: EdgeInsetsGeometry.only(bottom: 5),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: context.contrast),
                      borderRadius: BorderRadius.circular(Radiuses.large),
                    ),
                    child: Row(
                      children: [
                        LanguageItem(
                          imageLocation: "assets/images/png/language_id.png",
                          locale: TranslationService.localeId,
                          label: "Indonesia",
                        ),
                        LanguageItem(
                          imageLocation: "assets/images/png/language_en.png",
                          locale: TranslationService.localeEn,
                          label: "English",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radiuses.large),
                color: context.accent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    value: "account_setting".tr,
                    fontWeight: FontWeights.semiBold,
                    margin: EdgeInsetsGeometry.only(bottom: 5),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.settingAccountList.length,
                    itemBuilder: (context, index) {
                      var item = controller.settingAccountList[index];
                      return ListTile(
                        onTap: item.onTab,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        trailing: Icon(Icons.chevron_right_rounded),
                        title: TextComponent(
                          value: item.title?.tr,
                          fontWeight: FontWeights.medium,
                        ),
                        leading: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.accent2,
                          ),
                          child: ImageComponent(
                            localUrl: item.imageLocation,
                            height: 25,
                            width: 25,
                            color: context.text,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeItem extends StatelessWidget {
  const ThemeItem({
    super.key,
    required this.imageLocation,
    required this.itemThemeMode,
  });

  final String imageLocation;
  final ThemeMode itemThemeMode;

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    return Expanded(
      child: InkWell(
        onTap: () => themeController.toggleTheme(itemThemeMode),
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeController.themeMode.value == itemThemeMode
                  ? context.accent2
                  : null,
            ),
            child: ImageComponent(
              localUrl: imageLocation,
              width: 25,
              height: 25,
              color: context.text,
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.label,
    required this.imageLocation,
    required this.locale,
  });

  final String imageLocation;
  final Locale locale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => TranslationService.changeLocale(locale),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TranslationService.locale == locale
                    ? context.accent2
                    : null,
              ),
              child: ImageComponent(
                localUrl: imageLocation,
                width: 25,
                height: 25,
              ),
            ),
            TextComponent(value: label),
          ],
        ),
      ),
    );
  }
}
