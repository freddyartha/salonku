import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_setup_controller.dart';

class ServiceSetupView extends GetView<ServiceSetupController> {
  const ServiceSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceSetupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ServiceSetupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
