import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = ThemeController.instance;
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
                      border: Border.all(
                        color: themeController.themeMode.value == ThemeMode.dark
                            ? AppColors.darkAccent
                            : AppColors.lightAccent,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(right: 20),
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
                        value: "Nama Karyawan",
                        fontWeight: FontWeights.semiBold,
                        fontSize: FontSizes.h5,
                      ),
                      TextComponent(value: "Level Karyawan"),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 5,
                        ),
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageComponent(
                                localUrl: "assets/images/png/error_image.png",
                                width: 50,
                                height: 50,
                              ),
                              TextComponent(
                                margin: EdgeInsetsGeometry.only(top: 10),
                                value: "Test",
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // KategoriGawat(
                      //   title: "Gawat Kebakaran",
                      //   image: "assets/png/kebakaran.png",
                      // ),
                      // KategoriGawat(
                      //   title: "Gawat Kesehatan",
                      //   image: "assets/png/kesehatan.png",
                      // ),
                      // KategoriGawat(
                      //   title: "Gawat Kecelakaan",
                      //   image: "assets/png/kecelakaan.png",
                      // ),
                    ],
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
