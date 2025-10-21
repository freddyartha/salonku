import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';

import 'package:salonku/app/extension/theme_extension.dart';

enum NotifType { success, warning }

class ReusableWidgets {
  static PreferredSizeWidget generalAppBarWidget({
    required String title,
    Color? textColor,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return AppBar(
      foregroundColor: textColor,
      title: TextComponent(
        value: title,
        fontWeight: FontWeight.w600,
        fontColor: textColor ?? Get.context?.text,
        fontSize: FontSizes.h5,
      ),
      elevation: 0,
      centerTitle: false,
      leading: leading,
      actions: actions,
    );
  }

  // static Widget bannerInfoWidget({
  //   required IconData icon,
  //   required String title,
  //   required Color color,
  //   Color? fontColor,
  //   double? radius,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: color.withValues(alpha: 0.2),
  //       borderRadius: BorderRadius.circular(radius ?? Radiuses.regular),
  //     ),
  //     child: ListTile(
  //       horizontalTitleGap: 5,
  //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //       leading: Icon(icon, size: 40, color: color),
  //       title: TextComponent(
  //         value: title,
  //         fontSize: FontSizes.small,
  //         fontColor: fontColor ?? AppColors.black,
  //       ),
  //     ),
  //   );
  // }

  static Future<bool?> dialogConfirmation({
    String? title,
    String? message,
    IconData? icon,
    Widget? content,
    String? textConfirm,
    String? textCancel,
    bool isWithBatal = false,
    bool barrierDissmisible = true,
    bool onlyShowConfirm = false,
    Color? iconColor,
  }) async {
    return await Get.dialog<bool?>(
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Get.back(result: false);
        },
        child: AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          actionsPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radiuses.regular),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: icon != null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Icon(icon, size: 100, color: iconColor),
                ),
              ),
              Visibility(
                visible: title != null,
                child: Column(
                  children: [
                    TextComponent(
                      value: title ?? "",
                      fontSize: FontSizes.h6,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Visibility(
                visible: message != null,
                child: TextComponent(
                  value: message,
                  textAlign: TextAlign.center,
                  fontWeight: title != null ? FontWeight.w400 : FontWeight.w500,
                ),
              ),
              Visibility(
                visible: content != null,
                child: content ?? Container(),
              ),
            ],
          ),
          actions: [
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 12),
                child: onlyShowConfirm
                    ? ButtonComponent(
                        text: textConfirm ?? "submit".tr,
                        isMultilineText: true,
                        borderRadius: Radiuses.small,
                        onTap: () {
                          Get.back(result: true);
                        },
                      )
                    : isWithBatal
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: ButtonComponent(
                              text: textConfirm ?? "submit".tr,
                              isMultilineText: true,
                              onTap: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Flexible(
                            child: ButtonComponent(
                              text: textCancel ?? "batal".tr,
                              isMultilineText: true,
                              borderColor: Get.context?.contrast,
                              buttonColor: Get.context?.accent,
                              textColor: AppColors.darkText,
                              borderRadius: Radiuses.small,
                              onTap: () {
                                Get.back(result: false);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Flexible(
                            child: ButtonComponent(
                              text: "batal".tr,
                              isMultilineText: true,
                              borderColor: Get.context?.contrast,
                              buttonColor: Get.context?.accent,
                              textColor: AppColors.darkText,
                              borderRadius: Radiuses.small,
                              onTap: Get.back,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: ButtonComponent(
                              text: textCancel ?? "batal".tr,
                              isMultilineText: true,
                              borderColor: Get.context?.contrast,
                              buttonColor: Get.context?.accent,
                              textColor: AppColors.darkText,
                              borderRadius: Radiuses.small,
                              onTap: () {
                                Get.back(result: false);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: ButtonComponent(
                              text: textConfirm ?? "submit".tr,
                              borderRadius: Radiuses.small,
                              isMultilineText: true,
                              onTap: () {
                                Get.back(result: true);
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: barrierDissmisible,
    );
  }

  static Future<bool> dialogWarning(
    String? message, {
    showButton = false,
    String? text,
    Function()? function,
    bool barrierDissmisible = true,
  }) async {
    return await Get.dialog(
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Get.back(result: true);
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radiuses.regular),
          ),
          backgroundColor: Get.context?.accent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.danger,
                size: 60,
              ),
              const Padding(padding: EdgeInsets.all(7)),
              Text(
                textAlign: TextAlign.center,
                message ?? "-",
                style: const TextStyle(color: AppColors.darkText),
              ),
              showButton
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ButtonComponent(
                        onTap: function!,
                        text: text ?? "ok".tr,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDissmisible,
    );
  }

  // static Future<bool> dialogWithWidget({
  //   showButton = false,
  //   required List<Widget> children,
  //   String? textConfirm,
  //   String? textCancel,
  //   Function()? confirmFunction,
  //   Function()? cancelFunction,
  //   CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  // }) async {
  //   return await Get.dialog(
  //     PopScope(
  //       canPop: false,
  //       onPopInvokedWithResult: (didPop, result) {
  //         if (didPop) return;
  //         Get.back(result: true);
  //       },
  //       child: AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(Radiuses.regular),
  //         ),
  //         backgroundColor: AppColors.white,
  //         content: Column(
  //           crossAxisAlignment: crossAxisAlignment,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ...children,
  //             SizedBox(height: 20),
  //             Row(
  //               children: [
  //                 if (cancelFunction != null) ...[
  //                   SizedBox(width: 15),
  //                   Expanded(
  //                     child: ButtonComponent(
  //                       onTap: cancelFunction,
  //                       text: textCancel ?? "cancel".tr,
  //                       textColor: AppColors.red,
  //                       borderColor: AppColors.red,
  //                       buttonColor: AppColors.white,
  //                     ),
  //                   ),
  //                 ],
  //                 if (confirmFunction != null) ...[
  //                   Expanded(
  //                     child: ButtonComponent(
  //                       onTap: confirmFunction,
  //                       text: textConfirm ?? "ok".tr,
  //                       textColor: AppColors.darkBlue,
  //                       borderColor: AppColors.darkBlue,
  //                       buttonColor: AppColors.white,
  //                     ),
  //                   ),
  //                 ],
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static Future<bool> dialogSuccess({String? message, String? title}) async {
  //   return await Get.dialog(
  //     PopScope(
  //       canPop: false,
  //       onPopInvokedWithResult: (didPop, result) {
  //         if (didPop) return;
  //         Get.back(result: true);
  //       },
  //       child: AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(Radiuses.regular),
  //         ),
  //         backgroundColor: AppColors.white,
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.check_circle_outline_rounded,
  //               color: AppColors.darkBlue,
  //               size: 60,
  //             ),
  //             const Padding(padding: EdgeInsets.all(7)),
  //             Visibility(
  //               visible: title != null && title != "",
  //               child: TextComponent(
  //                 textAlign: TextAlign.center,
  //                 value: title ?? "",
  //                 fontSize: FontSizes.h6,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             Visibility(
  //               visible: message != null && message != "",
  //               child: TextComponent(
  //                 textAlign: TextAlign.center,
  //                 value: message ?? "",
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static Future<bool?> notifBottomSheet({
    required String subtitle,
    List<Widget>? children,
    String? title,
    NotifType notifType = NotifType.warning,
  }) {
    if (Get.isBottomSheetOpen == true) {
      Get.back();
    }
    return Get.bottomSheet<bool>(
      enableDrag: false,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Get.back(result: false);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Get.context?.accent,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      value:
                          title ??
                          (notifType == NotifType.success
                              ? "success".tr
                              : "error".tr),
                      fontWeight: FontWeight.w600,
                      fontSize: FontSizes.h6,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 40,
                      child: GestureDetector(
                        onTap: () => Get.back(result: false),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Get.context?.text.withValues(alpha: 0.06),
                          ),
                          child: Icon(Icons.close, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        ImageComponent(
                          localUrl: notifType == NotifType.warning
                              ? "assets/images/png/error.png"
                              : "assets/images/png/success.png",
                          height: 80,
                          width: Get.width,
                          boxFit: BoxFit.fitHeight,
                          color: notifType == NotifType.warning
                              ? AppColors.danger
                              : AppColors.info,
                          margin: EdgeInsets.only(bottom: 20),
                        ),
                        TextComponent(
                          value: subtitle,
                          textAlign: TextAlign.center,
                        ),
                        if (children != null) ...children,
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool?> confirmationBottomSheet({
    required List<Widget> children,
    String? title,
    String? textConfirm,
    String? textCancel,
    Color? confirmColor,
    bool withImage = false,
  }) {
    return Get.bottomSheet<bool>(
      isScrollControlled: true,
      enableDrag: false,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Get.back(result: null);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Get.context?.accent,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      value: title ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: FontSizes.h6,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 40,

                      child: GestureDetector(
                        onTap: () => Get.back(result: false),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Get.context?.accent2,
                          ),
                          child: Icon(Icons.close, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        withImage
                            ? Center(
                                child: ImageComponent(
                                  localUrl: "assets/images/question.png",
                                  height: 150,
                                  width: Get.width,
                                  boxFit: BoxFit.fitHeight,
                                  margin: EdgeInsets.only(bottom: 20),
                                ),
                              )
                            : SizedBox(height: 15),
                        ...children,
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 20,
                          children: [
                            Expanded(
                              child: ButtonComponent(
                                text: textCancel ?? "cancel".tr,
                                isMultilineText: true,
                                borderColor: Get.context?.contrast,
                                buttonColor: Get.context?.accent,
                                textColor: Get.context?.text,
                                borderRadius: Radiuses.regular,
                                onTap: () {
                                  Get.back(result: false);
                                },
                              ),
                            ),
                            Expanded(
                              child: ButtonComponent(
                                text: textConfirm ?? "ok".tr,
                                borderRadius: Radiuses.regular,
                                buttonColor: confirmColor,
                                isMultilineText: true,
                                onTap: () {
                                  Get.back(result: true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // static Future<bool?> customBottomSheet({
  //   required List<Widget> children,
  //   String? title,
  //   bool allowPopScope = true,
  // }) {
  //   return Get.bottomSheet<bool>(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     PopScope(
  //       canPop: false,
  //       onPopInvokedWithResult: (didPop, result) {
  //         if (allowPopScope) {
  //           if (didPop) return;
  //           Get.back(result: null);
  //         }
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(25),
  //         ),
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //         child: SafeArea(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   TextComponent(
  //                     value: title ?? "",
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: FontSizes.h6,
  //                     margin: EdgeInsets.only(right: 10),
  //                   ),
  //                   if (allowPopScope) ...[
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 10),
  //                       height: 40,
  //                       child: GestureDetector(
  //                         onTap: () => Get.back(result: false),
  //                         child: Container(
  //                           padding: EdgeInsets.all(5),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(100),
  //                             color: AppColors.black.withValues(alpha: 0.06),
  //                           ),
  //                           child: Icon(Icons.close, size: 30),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ],
  //               ),
  //               ...children,
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static Future<void> showImageBottomSheet(
  //   String item,
  //   bool isNetworkImage,
  // ) async {
  //   final screenWidth = Get.width;
  //   final screenHeight = Get.height * 0.75;

  //   // Ambil ukuran gambar dari File
  //   Future<Size> getFileImageSize(File file) async {
  //     final bytes = await file.readAsBytes();
  //     final codec = await ui.instantiateImageCodec(bytes);
  //     final frame = await codec.getNextFrame();
  //     final image = frame.image;
  //     return Size(image.width.toDouble(), image.height.toDouble());
  //   }

  //   await customBottomSheet(
  //     children: [
  //       LayoutBuilder(
  //         builder: (context, constraints) {
  //           if (isNetworkImage) {
  //             Size? imageSize;
  //             double? aspectRatio;
  //             double? imageHeight;
  //             final image = Image.network(item);

  //             image.image
  //                 .resolve(const ImageConfiguration())
  //                 .addListener(
  //                   ImageStreamListener((ImageInfo info, bool _) {
  //                     imageSize = Size(
  //                       info.image.width.toDouble(),
  //                       info.image.height.toDouble(),
  //                     );
  //                     aspectRatio = imageSize!.width / imageSize!.height;
  //                     imageHeight = screenWidth / aspectRatio!;
  //                   }),
  //                 );

  //             return ImageComponent(
  //               zoomable: true,
  //               networkUrl: item,
  //               width: screenWidth,
  //               height: imageHeight! > screenHeight
  //                   ? screenHeight
  //                   : imageHeight,
  //               boxFit: BoxFit.contain,
  //             );
  //           } else {
  //             return FutureBuilder<Size>(
  //               future: getFileImageSize(File(item)),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return const Center(
  //                     child: CircularProgressIndicator(
  //                       color: AppColors.primary,
  //                     ),
  //                   );
  //                 }

  //                 final imageSize = snapshot.data!;
  //                 final aspectRatio = imageSize.width / imageSize.height;
  //                 final imageHeight = screenWidth / aspectRatio;

  //                 return ImageComponent(
  //                   zoomable: true,
  //                   imageFromFile: item,
  //                   width: screenWidth,
  //                   height: imageHeight > screenHeight
  //                       ? screenHeight
  //                       : imageHeight,
  //                   boxFit: BoxFit.contain,
  //                 );
  //               },
  //             );
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }

  // static Widget carouselWidget({required List<ArticleModel> imageList}) {
  //   return CarouselSlider(
  //     items: imageList.map((item) {
  //       return Container(
  //         margin: EdgeInsets.only(top: 10, bottom: 20),
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.black.withValues(alpha: 0.5),
  //               blurRadius: 8,
  //               spreadRadius: 2,
  //               offset: Offset(0, 0),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(Radiuses.large),
  //           image: DecorationImage(
  //             fit: BoxFit.cover,
  //             alignment: Alignment.bottomCenter,
  //             image: NetworkImage(item.imageUrl),
  //           ),
  //         ),
  //         child: Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Container(
  //             padding: EdgeInsets.all(10),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [Colors.transparent, AppColors.white],
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //               ),
  //               borderRadius: BorderRadius.circular(Radiuses.large),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 TextComponent(
  //                   value: item.title,
  //                   fontColor: AppColors.white,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: FontSizes.h6,
  //                   maxLines: 10,
  //                 ),
  //                 TextComponent(
  //                   value: item.subtitle,
  //                   fontColor: AppColors.white,
  //                   fontSize: FontSizes.small,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //     options: CarouselOptions(
  //       height: Get.width * 0.8,
  //       autoPlay: true,
  //       enlargeCenterPage: true,
  //       autoPlayInterval: const Duration(seconds: 3),
  //       autoPlayAnimationDuration: const Duration(milliseconds: 1000),
  //     ),
  //   );
  // }

  // static Widget scannedDocCarouselWidget({
  //   required List<String> imageList,
  //   bool isNetworkImage = false,
  // }) {
  //   final CarouselSliderController imageController = CarouselSliderController();
  //   RxInt current = 0.obs;

  //   //sizes
  //   final screenWidth = Get.width;
  //   final screenHeight = Get.height * 0.75;

  //   // Ambil ukuran gambar dari File
  //   Future<Size> getFileImageSize(File file) async {
  //     final bytes = await file.readAsBytes();
  //     final codec = await ui.instantiateImageCodec(bytes);
  //     final frame = await codec.getNextFrame();
  //     final image = frame.image;
  //     return Size(image.width.toDouble(), image.height.toDouble());
  //   }

  //   Future<void> showImageBottomSheet(String item) async =>
  //       await customBottomSheet(
  //         title: "scan_result".tr,
  //         children: [
  //           LayoutBuilder(
  //             builder: (context, constraints) {
  //               if (isNetworkImage) {
  //                 Size? imageSize;
  //                 double? aspectRatio;
  //                 double? imageHeight;
  //                 final image = Image.network(item);

  //                 image.image
  //                     .resolve(const ImageConfiguration())
  //                     .addListener(
  //                       ImageStreamListener((ImageInfo info, bool _) {
  //                         imageSize = Size(
  //                           info.image.width.toDouble(),
  //                           info.image.height.toDouble(),
  //                         );
  //                         aspectRatio = imageSize!.width / imageSize!.height;
  //                         imageHeight = screenWidth / aspectRatio!;
  //                       }),
  //                     );

  //                 return ImageComponent(
  //                   zoomable: true,
  //                   networkUrl: item,
  //                   width: screenWidth,
  //                   height: imageHeight! > screenHeight
  //                       ? screenHeight
  //                       : imageHeight,
  //                   boxFit: BoxFit.contain,
  //                 );
  //               } else {
  //                 return FutureBuilder<Size>(
  //                   future: getFileImageSize(File(item)),
  //                   builder: (context, snapshot) {
  //                     if (!snapshot.hasData) {
  //                       return const Center(
  //                         child: CircularProgressIndicator(
  //                           color: AppColors.primary,
  //                         ),
  //                       );
  //                     }

  //                     final imageSize = snapshot.data!;
  //                     final aspectRatio = imageSize.width / imageSize.height;
  //                     final imageHeight = screenWidth / aspectRatio;

  //                     return ImageComponent(
  //                       zoomable: true,
  //                       imageFromFile: item,
  //                       width: screenWidth,
  //                       height: imageHeight > screenHeight
  //                           ? screenHeight
  //                           : imageHeight,
  //                       boxFit: BoxFit.contain,
  //                     );
  //                   },
  //                 );
  //               }
  //             },
  //           ),
  //         ],
  //       );

  //   if (imageList.length <= 1) {
  //     final item = imageList.first;
  //     return GestureDetector(
  //       onTap: () => showImageBottomSheet(item),
  //       child: Container(
  //         margin: EdgeInsets.all(10),
  //         clipBehavior: Clip.hardEdge,
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.black.withValues(alpha: 0.5),
  //               blurRadius: 8,
  //               offset: Offset(0, 0),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(Radiuses.large),
  //         ),
  //         child: ImageComponent(
  //           imageFromFile: isNetworkImage ? null : item,
  //           networkUrl: isNetworkImage ? item : null,
  //           width: screenWidth,
  //           boxFit: BoxFit.fitWidth,
  //         ),
  //       ),
  //     );
  //   } else {
  //     return ListView(
  //       padding: EdgeInsets.only(bottom: 20),
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       children: [
  //         CarouselSlider(
  //           items: imageList.map((item) {
  //             return GestureDetector(
  //               onTap: () => showImageBottomSheet(item),
  //               child: Container(
  //                 margin: EdgeInsets.symmetric(vertical: 10),
  //                 decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: AppColors.black.withValues(alpha: 0.5),
  //                       blurRadius: 8,
  //                       offset: Offset(0, 0),
  //                     ),
  //                   ],
  //                   borderRadius: BorderRadius.circular(Radiuses.large),
  //                   image: DecorationImage(
  //                     fit: BoxFit.cover,
  //                     alignment: Alignment.bottomCenter,
  //                     image: isNetworkImage
  //                         ? NetworkImage(item)
  //                         : FileImage(File(item)),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           carouselController: imageController,
  //           options: CarouselOptions(
  //             height: Get.height * 0.5,
  //             autoPlay: true,
  //             enlargeCenterPage: true,
  //             autoPlayInterval: const Duration(seconds: 8),
  //             autoPlayAnimationDuration: const Duration(seconds: 3),
  //             onPageChanged: (index, reason) => current.value = index,
  //           ),
  //         ),
  //         Obx(
  //           () => Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: imageList.asMap().entries.map((entry) {
  //               return GestureDetector(
  //                 onTap: () => imageController.animateToPage(entry.key),
  //                 child: Container(
  //                   width: current.value == entry.key ? 20 : 10,
  //                   height: 8,
  //                   margin: const EdgeInsets.symmetric(horizontal: 2),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.all(Radius.circular(3)),
  //                     color: (AppColors.primary).withValues(
  //                       alpha: current.value == entry.key ? 1 : 0.4,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }

  // static Widget listLoadingWidget({required int count, double? height}) {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.mediumgray,
  //     highlightColor: AppColors.lightgray,
  //     child: ListView.separated(
  //       padding: EdgeInsets.zero,
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: count,
  //       separatorBuilder: (context, index) => SizedBox(height: 10),
  //       itemBuilder: (context, index) => Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(Radiuses.regular),
  //         ),
  //         height: height ?? 80,
  //       ),
  //     ),
  //   );
  // }

  // static Widget formLoadingWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Shimmer.fromColors(
  //       baseColor: AppColors.mediumgray,
  //       highlightColor: AppColors.lightgray,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         spacing: 20,
  //         children: [
  //           Container(
  //             height: Get.height * 0.25,
  //             decoration: BoxDecoration(
  //               color: AppColors.white,
  //               borderRadius: BorderRadius.circular(Radiuses.large),
  //             ),
  //           ),
  //           ListView.separated(
  //             padding: EdgeInsets.zero,
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             itemCount: 6,
  //             separatorBuilder: (context, index) => SizedBox(height: 10),
  //             itemBuilder: (context, index) => Row(
  //               spacing: 10,
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     color: AppColors.white,
  //                     borderRadius: BorderRadius.circular(Radiuses.regular),
  //                   ),
  //                   height: 45,
  //                   width: 100,
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: AppColors.white,
  //                       borderRadius: BorderRadius.circular(Radiuses.regular),
  //                     ),
  //                     height: 45,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // static Widget generalPopScopeWidget({
  //   required Widget child,
  //   required bool Function() showConfirmationCondition,
  //   Function()? customBackAction,
  // }) {
  //   return PopScope(
  //     canPop: false,
  //     onPopInvokedWithResult: (didPop, result) async {
  //       if (didPop) return;
  //       if (showConfirmationCondition()) {
  //         bool? result = await ReusableWidgets.confirmationBottomSheet(
  //           textConfirm: "yes".tr,
  //           withImage: true,
  //           children: [TextComponent(value: "go_back_confirmation".tr)],
  //         );
  //         if (result == true) {
  //           if (customBackAction != null) {
  //             customBackAction();
  //           } else {
  //             Get.back();
  //           }
  //         }
  //       } else {
  //         if (customBackAction != null) {
  //           customBackAction();
  //         } else {
  //           Get.back();
  //         }
  //       }
  //     },
  //     child: child,
  //   );
  // }

  // static Widget generalShadowedContainer({
  //   required Widget child,
  //   double? radius,
  //   EdgeInsetsGeometry? margin,
  //   EdgeInsetsGeometry? padding,
  // }) {
  //   return Container(
  //     margin: margin,
  //     padding: padding,
  //     decoration: BoxDecoration(
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(radius ?? Radiuses.regular),
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColors.black.withValues(alpha: 0.3),
  //           blurRadius: 5,
  //           spreadRadius: 1,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),

  //     child: child,
  //   );
  // }

  // static Widget generalEditDeleteButtonWidget({
  //   required Function() editOnTap,
  //   required Function() deleteOnTap,
  // }) => Row(
  //   spacing: 20,
  //   children: [
  //     Expanded(
  //       child: ButtonComponent(
  //         onTap: editOnTap,
  //         text: "edit".tr,
  //         buttonColor: AppColors.primary,
  //         icon: "assets/images/edit.png",
  //         isSvg: false,
  //         iconSize: 25,
  //       ),
  //     ),
  //     Expanded(
  //       child: ButtonComponent(
  //         onTap: () async {
  //           bool? result = await confirmationBottomSheet(
  //             title: "general_delete_header".tr,
  //             withImage: true,
  //             children: [
  //               TextComponent(
  //                 textAlign: TextAlign.center,
  //                 value: "general_delete_subtitle".tr,
  //               ),
  //             ],
  //           );
  //           if (result == true) deleteOnTap();
  //         },
  //         text: "delete".tr,
  //         buttonColor: AppColors.red,
  //         icon: "assets/images/delete.png",
  //         isSvg: false,
  //         iconSize: 25,
  //       ),
  //     ),
  //   ],
  // );

  // static Widget generalNotFoundWidget() => Container(
  //   margin: EdgeInsets.symmetric(horizontal: 40),
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     spacing: 20,
  //     children: [
  //       Image.asset("assets/images/not_found.png"),
  //       TextComponent(
  //         value: "general_not_found".tr,
  //         fontSize: FontSizes.h6,
  //         fontWeight: FontWeight.w600,
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   ),
  // );
}
