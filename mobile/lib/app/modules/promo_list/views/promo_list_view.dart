import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/routes/app_pages.dart';

import '../controllers/promo_list_controller.dart';

class PromoListView extends GetView<PromoListController> {
  const PromoListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(title: "promo".tr),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ReusableWidgets.generalCreateDataWidget(
        context,
        () => Get.toNamed(
          Routes.PROMO_SETUP,
        )?.then((v) => controller.listCon.refresh()),
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
              controller: controller.searchController,
              placeHolder: "search".tr,
              prefixIcon: Icon(Icons.search, size: 25),
              marginBottom: 0,
            ),
          ),
          ListComponent(
            controller: controller.listCon,
            editAction: (item) => controller.itemOnTap(item.id, true),
            deleteAction: (item) => controller.deletData(item.id),
            itemBuilder: (item) => ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              onTap: () => controller.itemOnTap(item.id, false),
              title: TextComponent(
                value: item.nama,
                fontWeight: FontWeights.semiBold,
                fontSize: FontSizes.h6,
              ),
              // isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.potonganHarga != null)
                    TextComponent(
                      value:
                          "Discount ${item.currencyCode} ${InputFormatter.toCurrency(item.potonganHarga)}",
                      maxLines: 3,
                    ),

                  if (item.potonganPersen != null)
                    TextComponent(
                      value: "Discount ${item.potonganPersen}%",
                      maxLines: 3,
                    ),
                  TextComponent(
                    value:
                        "${InputFormatter.displayDate(item.berlakuMulai)} - ${InputFormatter.displayDate(item.berlakuSampai)}",
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
