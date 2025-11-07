import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:shimmer/shimmer.dart';

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

  static Widget generalBottomDecoration() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: Get.width,
        height: Get.width,
        padding: EdgeInsets.only(top: 80, right: 80),
        decoration: BoxDecoration(
          color: Get.context?.accent,
          borderRadius: BorderRadius.only(topRight: Radius.circular(Get.width)),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.context?.accent2,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Get.height),
            ),
          ),
        ),
      ),
    );
  }

  static Widget generalCreateDataWidget(
    BuildContext context,
    dynamic Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.contrast,
          boxShadow: [
            BoxShadow(
              color: context.accent2,
              blurRadius: 5,
              offset: Offset(4, 5),
            ),
          ],
        ),
        height: 60,
        width: 60,
        child: Center(
          child: ImageComponent(
            localUrl: "assets/images/png/create.png",
            boxFit: BoxFit.contain,
            color: AppColors.darkText,
          ),
        ),
      ),
    );
  }

  static Widget generalCircleDecoration({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: Get.width / 2,
        height: Get.width / 2,

        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.context?.accent,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.context?.accent2,
          ),
        ),
      ),
    );
  }

  static Widget salonTileWidget(SalonModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: TextComponent(
            value: model.namaSalon,
            fontWeight: FontWeights.semiBold,
            fontSize: FontSizes.h5,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(value: model.alamat),
              TextComponent(value: model.phone),
            ],
          ),
          leading: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ImageComponent(
              networkUrl: model.logoUrl ?? "",
              height: 50,
              width: 50,
              boxFit: BoxFit.cover,
            ),
          ),
        ),
        if (model.cabang != null && model.cabang!.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: model.cabang!.length,
              itemBuilder: (context, index) {
                final cabang = model.cabang![index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.contrast),
                    borderRadius: BorderRadius.circular(Radiuses.regular),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: TextComponent(
                      value: "${cabang.nama} (${cabang.phone})",
                      fontWeight: FontWeights.semiBold,
                    ),
                    subtitle: TextComponent(value: cabang.alamat),
                  ),
                );
              },
            ),
          ),
        ],
      ],
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
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
                        : SizedBox(
                            height: title == null || title.isEmpty ? 0 : 15,
                          ),

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
          ),
        ),
      ),
    );
  }

  static Future<bool?> customBottomSheet({
    required List<Widget> children,
    String? title,
    bool allowPopScope = true,
  }) {
    return Get.bottomSheet<bool>(
      isScrollControlled: true,
      enableDrag: true,
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (allowPopScope) {
            if (didPop) return;
            Get.back(result: null);
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height * 0.9),
          child: Container(
            decoration: BoxDecoration(
              color: Get.context?.accent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
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
                      if (allowPopScope) ...[
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
                    ],
                  ),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool?> fullScreenBottomSheet({
    required List<Widget> children,
    String? title,
    bool allowPopScope = true,
  }) {
    return Get.bottomSheet<bool>(
      isScrollControlled: true,
      enableDrag: false,
      PopScope(
        canPop: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height * 0.7),
          child: Scaffold(
            resizeToAvoidBottomInset: false, // <- supaya sheet gak naik
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                color: Get.context?.accent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          value: title ?? "",
                          fontWeight: FontWeight.w600,
                          fontSize: FontSizes.h6,
                        ),
                        if (allowPopScope)
                          GestureDetector(
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
                      ],
                    ),

                    // Konten scrollable
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: children),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // return Get.bottomSheet<bool>(
    //   enableDrag: false,
    //   isScrollControlled: true,
    //   // PopScope(
    //   //   canPop: false,
    //   //   onPopInvokedWithResult: (didPop, result) {
    //   //     if (allowPopScope) {
    //   //       if (didPop) return;
    //   //       Get.back(result: null);
    //   //     }
    //   //   },
    //   //   child:
    //   Container(
    //     height: MediaQuery.of(Get.context!).size.height * 0.8,
    //     decoration: BoxDecoration(
    //       color: Get.context?.accent,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(25),
    //         topRight: Radius.circular(25),
    //       ),
    //     ),
    //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //     child: Scaffold(
    //       backgroundColor: Colors.transparent,
    //       resizeToAvoidBottomInset: false,
    //       body: SafeArea(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 TextComponent(
    //                   value: title ?? "",
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: FontSizes.h6,
    //                   margin: EdgeInsets.only(right: 10),
    //                 ),
    //                 if (allowPopScope) ...[
    //                   Container(
    //                     margin: EdgeInsets.only(bottom: 10),
    //                     height: 40,
    //                     child: GestureDetector(
    //                       onTap: () => Get.back(result: false),
    //                       child: Container(
    //                         padding: EdgeInsets.all(5),
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(100),
    //                           color: Get.context?.accent2,
    //                         ),
    //                         child: Icon(Icons.close, size: 30),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ],
    //             ),
    //             ListView(
    //               shrinkWrap: true,
    //               physics: ClampingScrollPhysics(),
    //               children: [...children],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   // ),
    // );
  }

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

  static Widget generalSetupPageWidget(
    BuildContext context,
    SetupBaseController controller, {
    required String title,
    required List<Widget> children,
    required bool Function() showConfirmationCondition,
    dynamic Function()? saveOnTap,
    dynamic Function()? cancelEditOnTap,
    bool withBottomSafeArea = true,
    bool allowEdit = true,
  }) {
    return Stack(
      children: [
        Container(
          color: context.primary,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned.fill(child: ReusableWidgets.generalBottomDecoration()),
        generalPopScopeWidget(
          showConfirmationCondition: showConfirmationCondition,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: ReusableWidgets.generalAppBarWidget(
              title: title.tr,
              actions: allowEdit
                  ? [
                      if (controller.isEditable.value &&
                          controller.itemId != null) ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: context.accent2,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.isEditable.value = false;
                              if (cancelEditOnTap != null) {
                                cancelEditOnTap();
                              }
                            },
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ] else if (!controller.isEditable.value &&
                          controller.itemId != null) ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: context.accent2,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.isEditable.value = true;
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ]
                  : null,
            ),
            body: SafeArea(
              bottom: withBottomSafeArea,
              child: ListView(
                key: GlobalKey(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Radiuses.extraLarge),
                        bottomRight: Radius.circular(Radiuses.extraLarge),
                      ),
                      color: context.accent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...children,

                        if (saveOnTap != null) ...[
                          Visibility(
                            visible: controller.isEditable.value,
                            child: ButtonComponent(
                              onTap: saveOnTap,
                              text: "save".tr,
                              margin: EdgeInsets.only(top: 50),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget listLoadingWidget({
    required int count,
    double? height,
    double? radius,
    double? itemHorizontalMargin,
    List<Widget>? children,
  }) {
    return children != null
        ? ListView.separated(
            padding: EdgeInsets.only(top: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: count,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: itemHorizontalMargin ?? 0,
              ),
              decoration: BoxDecoration(
                color: context.accent,
                borderRadius: BorderRadius.circular(radius ?? Radiuses.regular),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightText.withValues(alpha: 0.3),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: height ?? 80,
              child: Shimmer.fromColors(
                baseColor: context.accent,
                highlightColor: context.accent2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            ),
          )
        : Shimmer.fromColors(
            baseColor: Get.context?.accent ?? AppColors.darkContrast,
            highlightColor: Get.context?.accent2 ?? AppColors.lightAccent,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: count,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Get.context?.accent,
                  borderRadius: BorderRadius.circular(
                    radius ?? Radiuses.regular,
                  ),
                ),
                height: height ?? 80,
              ),
            ),
          );
  }

  static Widget generalNotFoundWidget({
    required double width,
    bool isOffset = true,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: isOffset
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        if (isOffset) SizedBox(height: Get.height * 0.1),
        Image.asset(
          'packages/gawat_darurat/assets/png/not_found.png',
          width: width,
          fit: BoxFit.contain,
        ),
        TextComponent(
          value: "data_not_found".tr,
          fontSize: FontSizes.h4,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

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

  static Widget generalPopScopeWidget({
    required Widget child,
    required bool Function() showConfirmationCondition,
    Function()? customBackAction,
  }) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (showConfirmationCondition()) {
          bool? result = await ReusableWidgets.confirmationBottomSheet(
            textConfirm: "yes".tr,
            withImage: true,
            children: [TextComponent(value: "go_back_confirmation".tr)],
          );
          if (result == true) {
            if (customBackAction != null) {
              customBackAction();
            } else {
              Get.back();
            }
          }
        } else {
          if (customBackAction != null) {
            customBackAction();
          } else {
            Get.back();
          }
        }
      },
      child: child,
    );
  }

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
}
