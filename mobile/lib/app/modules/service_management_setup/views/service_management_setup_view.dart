import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/custom_multiple_component.dart';
import 'package:salonku/app/components/others/select_multiple_component.dart';
import 'package:salonku/app/components/others/select_single_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/service_management_setup_controller.dart';

class ServiceManagementSetupView
    extends GetView<ServiceManagementSetupController> {
  const ServiceManagementSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: ReusableWidgets.generalSetupPageWidget(
              context,
              controller,
              title: "transaction".tr,
              showConfirmationCondition: controller.showConfirmationCondition,
              withBottomSafeArea: false,
              children: [
                SelectSingleComponent(
                  controller: controller.selectClientCon,
                  label: "select_client".tr,
                  editable: controller.isEditable.value,
                ),
                SelectMultipleComponent(
                  controller: controller.selectServicesCon,
                  label: "select_services".tr,
                  editable: controller.isEditable.value,
                ),
                SizedBox(
                  width: Get.width,
                  child: InputRadioComponent(
                    controller: controller.showCustomServiceCon,
                    label: "create_custom_service_for_this_transaction_only".tr,
                    editable: controller.isEditable.value,
                  ),
                ),
                Visibility(
                  visible: controller.customService.value,
                  child: CustomMultipleComponent(
                    controller: controller.customServicesCon,
                    label: "create_custom_services".tr,
                    required: true,
                    editable: controller.isEditable.value,
                  ),
                ),
                SelectSingleComponent(
                  controller: controller.selectPromoCon,
                  label: "select_promo".tr,
                  editable: controller.isEditable.value,
                ),
                SelectSingleComponent(
                  controller: controller.selectPaymentCon,
                  required: true,
                  label: "select_payment_method".tr,
                  editable: controller.isEditable.value,
                ),
                SelectSingleComponent(
                  controller: controller.selectCabangCon,
                  required: true,
                  label: "select_branch".tr,
                  editable:
                      controller.userModel.cabangs != null &&
                          controller.userModel.cabangs!.isNotEmpty
                      ? false
                      : controller.isEditable.value,
                ),
                InputTextComponent(
                  label: "catatan".tr,
                  placeHolder: "placeholder_catatan".tr,
                  controller: controller.catatanCon,
                  editable: controller.isEditable.value,
                ),
              ],
              saveOnTap: controller.saveOnTap,
              cancelEditOnTap: () =>
                  controller.addValueInputFields(controller.model),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Radiuses.large)),
                border: Border.all(color: context.contrast),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        TextComponent(value: "total_services".tr),
                        Expanded(
                          child: TextComponent(
                            fontWeight: FontWeights.bold,
                            textAlign: TextAlign.right,
                            fontSize: FontSizes.h6,
                            value:
                                "${controller.currencyCode} ${InputFormatter.toCurrency(controller.totalServices + controller.totalCustomService)}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        TextComponent(value: "total_discount".tr),
                        Expanded(
                          child: TextComponent(
                            fontWeight: FontWeights.bold,
                            textAlign: TextAlign.right,
                            fontSize: FontSizes.h6,
                            value:
                                controller.selectPromoCon.value != null &&
                                    controller.selectPromoCon.value!.addedValue
                                        .toString()
                                        .contains("%")
                                ? "(${controller.selectPromoCon.value!.subtitle}) ${controller.currencyCode} ${InputFormatter.toCurrency(controller.totalPromo)}"
                                : "${controller.currencyCode} ${InputFormatter.toCurrency(controller.totalPromo)}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: TextComponent(
                      value: "grand_total".tr,
                      fontWeight: FontWeights.semiBold,
                    ),
                    trailing: TextComponent(
                      fontWeight: FontWeights.bold,
                      fontSize: FontSizes.h4,
                      value:
                          "${controller.currencyCode} ${InputFormatter.toCurrency(controller.grandTotal.value)}",
                    ),
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
