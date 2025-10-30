import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/payment_method_setup_controller.dart';

class PaymentMethodSetupView extends GetView<PaymentMethodSetupController> {
  const PaymentMethodSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "payment_method".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "payment_method".tr,
            placeHolder: "placeholder_payment_method".tr,
            controller: controller.paymentMethodCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "code".tr,
            placeHolder: "placeholder_code".tr,
            controller: controller.codeCon,
            editable: controller.isEditable.value,
            required: true,
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
