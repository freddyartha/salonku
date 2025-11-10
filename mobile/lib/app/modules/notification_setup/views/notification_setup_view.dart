import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_setup_controller.dart';

class NotificationSetupView extends GetView<NotificationSetupController> {
  const NotificationSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationSetupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotificationSetupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
