import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Center(child: TextComponent(value: "Onboarding")),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: controller.onStartPage,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: Get.width / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Radiuses.large),
                          color: context.contrast,
                        ),
                        child: TextComponent(
                          value: "Prev",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: controller.onStartPage,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: Get.width / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Radiuses.large),
                          color: context.contrast,
                        ),
                        child: TextComponent(
                          value: "Next",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
