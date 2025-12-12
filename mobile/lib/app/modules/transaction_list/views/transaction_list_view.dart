import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/transaction_list_controller.dart';

class TransactionListView extends GetView<TransactionListController> {
  const TransactionListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "transaction".tr,
        actions: [
          GestureDetector(
            onTap: controller.downloadReportOnTap,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.accent2,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.document_scanner_outlined, color: context.text),
            ),
          ),
        ],
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
            controller: controller.serviceListCon,
            withSeparator: true,
            itemBuilder: (item) => ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              horizontalTitleGap: 10,
              onTap: () => controller.itemOnTap(item.id, item.type),
              leading: Icon(
                item.type.toLowerCase() == 'pemasukan'
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down,
                color: item.type.toLowerCase() == 'pemasukan'
                    ? AppColors.success
                    : AppColors.danger,
                size: 30,
              ),
              title: TextComponent(
                value: item.keterangan ?? item.type,
                fontWeight: FontWeights.semiBold,
                fontSize: FontSizes.h6,
              ),
              subtitle: TextComponent(
                value: InputFormatter.displayDate(item.createdAt),
              ),
              trailing: TextComponent(
                value:
                    "${controller.localDataSource.salonData.currencyCode} ${InputFormatter.toCurrency(item.nominal)}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
