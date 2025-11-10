import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/notification_list_controller.dart';

class NotificationListView extends GetView<NotificationListController> {
  const NotificationListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(title: "notification".tr),
      body: const Center(
        child: TextComponent(
          padding: EdgeInsetsGeometry.all(10),
          value:
              'INI AKAN BERISI LIST NOTIFIKASI YANG MASUK, MASIH RAGU APAKAH AKAN ADA NOTIF ATAU TIDAK',
          textAlign: TextAlign.center,
          fontWeight: FontWeights.semiBold,
        ),
      ),
    );
  }
}
