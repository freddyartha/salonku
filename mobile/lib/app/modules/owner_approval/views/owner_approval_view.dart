import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/owner_approval_controller.dart';

class OwnerApprovalView extends GetView<OwnerApprovalController> {
  const OwnerApprovalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ReusableWidgets.generalBottomDecoration(),
          ReusableWidgets.generalCircleDecoration(right: 0),
          SafeArea(
            child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(15),
              children: [
                ImageComponent(
                  localUrl: controller.approved == null
                      ? "assets/images/png/error.png"
                      : "assets/images/png/error_image.png",
                  color: context.text,
                  margin: EdgeInsets.only(bottom: 30),
                ),
                if (controller.approved == null) ...[
                  TextComponent(
                    value: "menunggu_approval_title".tr,
                    fontSize: FontSizes.h4,
                    fontWeight: FontWeights.bold,
                    textAlign: TextAlign.center,
                  ),
                  TextComponent(
                    value: "menunggu_approval_subtitle".tr,
                    textAlign: TextAlign.center,
                  ),
                ],

                if (controller.approved == false) ...[
                  TextComponent(
                    value: "permintaan_ditolak_title".tr,
                    fontSize: FontSizes.h4,
                    fontWeight: FontWeights.bold,
                    textAlign: TextAlign.center,
                  ),
                  TextComponent(
                    value: "permintaan_ditolak_subtitle".tr,
                    textAlign: TextAlign.center,
                  ),
                ],

                GetBuilder<OwnerApprovalController>(
                  builder: (controller) {
                    return controller.salonModel != null
                        ? Container(
                            width: Get.width,
                            margin: EdgeInsets.only(top: 20),

                            decoration: BoxDecoration(
                              border: Border.all(color: context.contrast),
                              borderRadius: BorderRadius.circular(
                                Radiuses.large,
                              ),
                            ),
                            child: ReusableWidgets.salonTileWidget(
                              controller.salonModel!,
                            ),
                          )
                        : SizedBox();
                  },
                ),

                TextComponent(
                  margin: EdgeInsetsGeometry.only(top: 30, bottom: 10),
                  value: "bukan_salon_ini".tr,
                  textAlign: TextAlign.center,
                ),
                ButtonComponent(
                  onTap: controller.userRemoveSalon,
                  text: "ganti_salon".tr,
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: controller.signOutOnTap,
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        offset: Offset(2, 4),
                        spreadRadius: 2,
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: context.accent2,
                  ),
                  child: ImageComponent(
                    localUrl: "assets/images/png/sign_out.png",
                    height: 25,
                    width: 25,
                    color: context.text,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
