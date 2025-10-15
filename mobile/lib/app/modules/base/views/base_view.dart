import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/components/images/image_component.dart';

import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          controller.pages[controller.selectedId.value](),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: context.accent,
                      // color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: controller.menuItemList.map((item) {
                        bool isSelected =
                            controller.selectedId.value == item.id;
                        return GestureDetector(
                          onTap: () => controller.itemOnTap(item.id!),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? context.contrast : null,
                            ),
                            padding: EdgeInsets.all(isSelected ? 10 : 8),
                            child: ImageComponent(
                              localUrl: item.imageLocation,
                              height: isSelected ? 40 : 30,
                              width: isSelected ? 40 : 30,
                              boxFit: BoxFit.contain,
                              color: context.isLight && isSelected
                                  ? AppColors.darkText
                                  : context.text,
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
        ],
      );
    });
  }
}
