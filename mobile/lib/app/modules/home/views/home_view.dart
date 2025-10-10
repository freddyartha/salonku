import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tema Gelap/Terang'),
        actions: [
          IconButton(
            icon: Icon(
              themeController.themeMode.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: Get.width,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          TextComponent(value: 'Halo Dunia!'),
          InputTextComponent(
            controller: controller.testCon,
            label: "Testing Input Text Component",
          ),
          InputTextComponent(
            controller: controller.test1Con,
            label: "Testing Input Text Component",
            editable: false,
          ),
          InputRadioComponent(
            controller: controller.testRadioCon,
            label: "Testing Input Radio Compenent",
          ),
        ],
      ),
    );
  }
}
