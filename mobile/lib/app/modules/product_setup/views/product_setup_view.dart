import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';

import '../controllers/product_setup_controller.dart';

class ProductSetupView extends GetView<ProductSetupController> {
  const ProductSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "product".tr,
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          InputTextComponent(
            label: "brand".tr,
            placeHolder: "placeholder_brand".tr,
            controller: controller.brandCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "nama_produk".tr,
            placeHolder: "placeholder_nama_produk".tr,
            controller: controller.namaCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "ukuran".tr,
            placeHolder: "placeholder_ukuran".tr,
            controller: controller.ukuranCon,
            editable: controller.isEditable.value,
          ),
          InputTextComponent(
            label: "satuan".tr,
            placeHolder: "placeholder_satuan".tr,
            controller: controller.satuanCon,
            editable: controller.isEditable.value,
            required: true,
          ),
          InputTextComponent(
            label: "harga_satuan".tr,
            placeHolder: "placeholder_harga_satuan".tr,
            controller: controller.hargaSatuanCon,
            editable: controller.isEditable.value,
            prefixText: controller.currencyCode,
            required: true,
          ),

          // SelectMultipleComponent(
          //   controller: controller.selectSupplierCon,
          //   label: "supplier".tr,
          //   required: true,
          //   editable: controller.isEditable.value,
          // ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
