import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_list_controller.dart';

class ServiceListView extends GetView<ServiceListController> {
  const ServiceListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ServiceListView'), centerTitle: true),
      body: Center(
        child: Text(
          controller.idSalon.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
