import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/profile_change_language_controller.dart';

class ProfileChangeLanguageView
    extends GetView<ProfileChangeLanguageController> {
  const ProfileChangeLanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "title_change_language".tr,
        textColor: AppColors.danger,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InputRadioComponent(
            controller: controller.pilihBahasaCon,
            position: CheckboxPosition.right,
            spacing: 20,
          ),
        ),
      ),
    );
  }
}
