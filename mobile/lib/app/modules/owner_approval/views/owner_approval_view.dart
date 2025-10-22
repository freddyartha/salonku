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
                  margin: EdgeInsets.only(bottom: 50),
                ),
                if (controller.approved == null) ...[
                  TextComponent(
                    value: "Menunggu Approval dari Owner Salon",
                    fontSize: FontSizes.h4,
                    fontWeight: FontWeights.bold,
                    textAlign: TextAlign.center,
                  ),
                  TextComponent(
                    value:
                        "Selangkah lagi! kamu dapat menggunakan semua fitur SalonKu, untuk saat ini kamu diarahkan ke halaman menuggu approval dari Owner Salon. Setelah Owner Salon menerima permintaan staff kamu, semua fitur SalonKu dapat kamu gunakan!",

                    textAlign: TextAlign.center,
                  ),
                ],

                if (controller.approved == false) ...[],

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
                  margin: EdgeInsetsGeometry.only(top: 50, bottom: 10),
                  value:
                      "Bukan ini salon yang kamu maksud? \nklik tombol 'Ganti Salon' di bawah",
                  textAlign: TextAlign.center,
                ),
                ButtonComponent(
                  onTap: controller.userRemoveSalon,
                  text: "Ganti Salon",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
