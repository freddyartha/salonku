import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.instance;
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.selectedId.value](),
        bottomNavigationBar: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: themeController.themeMode.value == ThemeMode.dark
                      ? AppColors.darkAccent
                      : AppColors.lightAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: controller.menuItemList.map((item) {
                    bool isSelected = controller.selectedId.value == item.id;
                    return GestureDetector(
                      onTap: () => controller.itemOnTap(item.id!),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              isSelected &&
                                  themeController.themeMode.value ==
                                      ThemeMode.dark
                              ? AppColors.darkContrast
                              : isSelected &&
                                    themeController.themeMode.value ==
                                        ThemeMode.light
                              ? AppColors.lightContrast
                              : null,
                        ),
                        padding: EdgeInsets.all(isSelected ? 10 : 15),
                        child: ImageComponent(
                          localUrl: item.imageLocation,
                          height: isSelected ? 40 : 30,
                          width: isSelected ? 40 : 30,
                          boxFit: BoxFit.contain,
                          color:
                              themeController.themeMode.value ==
                                      ThemeMode.dark ||
                                  isSelected
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
