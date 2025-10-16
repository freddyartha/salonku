import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/buttons/button_component.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RegisterView'), centerTitle: true),
      body: Center(
        child: ButtonComponent(onTap: controller.logout, text: "Logout"),
      ),
    );
  }
}
