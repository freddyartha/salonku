import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/others/pie_chart_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.08,
        ),
        child: ReusableWidgets.generalCreateDataWidget(
          context,
          () => Get.toNamed(Routes.SERVICE_MANAGEMENT_SETUP),
          // ?.then((v) => controller.listCon.refresh()),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: context.accent),
                    ),
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(right: 15),
                    child: ImageComponent(
                      localUrl: "assets/images/png/error_image.png",
                      height: 55,
                      width: 55,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        value: controller.userData.nama,
                        fontWeight: FontWeights.semiBold,
                        fontSize: FontSizes.h5,
                      ),
                      TextComponent(
                        value: ReusableStatics.getLevelUser(
                          controller.userData.level,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Radiuses.large),
                      color: context.accent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          value: "salon_information".tr,
                          fontWeight: FontWeights.semiBold,
                          margin: EdgeInsetsGeometry.only(bottom: 10),
                        ),
                        GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          physics: NeverScrollableScrollPhysics(),
                          children: controller.homeBaseMenus
                              .map(
                                (item) => GestureDetector(
                                  onTap: item.onTab,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: context.accent2,
                                          borderRadius: BorderRadius.circular(
                                            Radiuses.large,
                                          ),
                                          border: Border.all(
                                            color: context.contrast,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextComponent(
                                            value: item.title?.tr,
                                            textAlign: TextAlign.right,
                                            height: 1,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: Get.width / 6.5,
                                        height: Get.width / 6.5,
                                        decoration: BoxDecoration(
                                          color: context.contrast,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(
                                              Radiuses.extraLarge,
                                            ),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: ImageComponent(
                                            localUrl: item.imageLocation ?? "",
                                            color: AppColors.darkText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Radiuses.large),
                      color: context.accent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          value: "today_transaction".tr,
                          fontWeight: FontWeights.semiBold,
                          margin: EdgeInsetsGeometry.only(bottom: 10),
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(value: "income".tr),
                                  TextComponent(
                                    value: "IDR 1.500.000",
                                    fontSize: FontSizes.h6,
                                    fontWeight: FontWeights.semiBold,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextComponent(value: "expense".tr),
                                  TextComponent(
                                    value: "IDR 500.000",
                                    fontSize: FontSizes.h6,
                                    fontWeight: FontWeights.semiBold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: PieChartComponent(
                            label: "today_transaction".tr,
                            model: controller.chartMingguanList,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
