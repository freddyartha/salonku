import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';

import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // GridView(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3,
                  //         crossAxisSpacing: 10,
                  //         mainAxisSpacing: 5,
                  //       ),
                  //   children: [
                  //     InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: AppColors.lightAccent),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         padding: const EdgeInsets.all(5),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             ImageComponent(
                  //               localUrl: "assets/images/png/error_image.png",
                  //               width: 50,
                  //               height: 50,
                  //             ),
                  //             TextComponent(
                  //               margin: EdgeInsetsGeometry.only(top: 10),
                  //               value: "Test",
                  //               fontWeight: FontWeight.w500,
                  //               textAlign: TextAlign.center,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
