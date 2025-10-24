import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/routes/app_pages.dart';

import '../controllers/service_list_controller.dart';

class ServiceListView extends GetView<ServiceListController> {
  const ServiceListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(title: "Service List"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ReusableWidgets.generalCreateDataWidget(
        context,
        () => Get.toNamed(
          Routes.SERVICE_SETUP,
        )?.then((v) => controller.serviceListCon.refresh()),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Radiuses.large),
                bottomRight: Radius.circular(Radiuses.large),
              ),
              color: context.accent,
            ),
            child: InputTextComponent(
              controller: controller.searchCon,
              placeHolder: "search_notification".tr,
              prefixIcon: Icon(Icons.search, size: 25),
              marginBottom: 0,
            ),
          ),
          ListComponent(
            controller: controller.serviceListCon,
            editAction: (item) => print(item.id),
            deleteAction: (item) => print(item.id),
            itemBuilder: (item) => ListTile(
              title: TextComponent(value: item.nama),
              subtitle: TextComponent(value: item.deskripsi),
            ),
          ),
        ],
      ),
    );
  }
}
