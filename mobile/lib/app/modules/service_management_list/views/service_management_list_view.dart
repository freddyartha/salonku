import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_management_list_controller.dart';

class ServiceManagementListView
    extends GetView<ServiceManagementListController> {
  const ServiceManagementListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceManagementListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ServiceManagementListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
