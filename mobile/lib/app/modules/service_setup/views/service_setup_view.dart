import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/service_setup_controller.dart';

class ServiceSetupView extends GetView<ServiceSetupController> {
  const ServiceSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return ReusableWidgets.generalSetupPageWidget(
      context,
      title: "Service",
      children: [
        InputTextComponent(
          label: "Nama Service",
          controller: controller.namaServiceCon,
        ),
        Container(color: context.contrast, height: 50),
      ],
      saveOnTap: () {},
    );
  }
}
