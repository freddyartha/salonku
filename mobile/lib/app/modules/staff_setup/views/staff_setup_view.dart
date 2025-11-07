import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/inputs/input_datetime_component.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/select_single_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/staff_setup_controller.dart';

class StaffSetupView extends GetView<StaffSetupController> {
  const StaffSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReusableWidgets.generalSetupPageWidget(
        context,
        controller,
        title: "staff".tr,
        allowEdit: ReusableStatics.userIsStaff(
          controller.localDataSource.userData,
        ),
        showConfirmationCondition: controller.showConfirmationCondition,
        children: [
          if (!controller.isLoading.value &&
              !ReusableStatics.userIsStaff(
                controller.localDataSource.userData,
              )) ...[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: context.accent2.withValues(alpha: 0.7),
                borderRadius: BorderRadius.all(Radius.circular(Radiuses.large)),
                border: Border.all(color: context.contrast),
              ),
              child: Column(
                children: [
                  InputTextComponent(
                    label: "Level",
                    controller: controller.levelCon,
                    editable: controller.isEditable.value,
                  ),
                  InputDatetimeComponent(
                    label: "approved_date".tr,
                    controller: controller.tanggalLahirCon,
                    placeHolder: "placeholder_approved_date".tr,
                    editable: controller.isEditable.value,
                    marginBottom: controller.localDataSource.userData.level != 3
                        ? 30
                        : 10,
                  ),
                  controller.localDataSource.userData.level != 3
                      ? ButtonComponent(
                          onTap: () => controller.promoteDemoteStaff(
                            controller.userLevel.value == 2 ? true : false,
                          ),
                          buttonColor: controller.userLevel.value == 2
                              ? context.contrast
                              : AppColors.danger,
                          text: controller.userLevel.value == 2
                              ? "promote_staff_to_coowner".tr
                              : "demote_coowner_to_staff".tr,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
          InputTextComponent(
            label: "nama".tr,
            controller: controller.namaCon,
            placeHolder: "placeholder_nama".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          InputPhoneComponent(
            controller: controller.phoneCon,
            label: "nomor_hp".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          InputTextComponent(
            label: "nomor_id_card".tr,
            controller: controller.nikCon,
            placeHolder: "placeholder_nomor_id_card".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          InputRadioComponent(
            controller: controller.jenisKelaminCon,
            label: "pilih_jenis_kelamin".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          InputDatetimeComponent(
            label: "tanggal_lahir".tr,
            controller: controller.tanggalLahirCon,
            placeHolder: "placeholder_tanggal_lahir".tr,
            required: true,
            editable: controller.isEditable.value,
          ),
          InputTextComponent(
            label: "alamat".tr,
            controller: controller.alamatCon,
            placeHolder: "placeholder_alamat".tr,
            required: true,
            editable: controller.isEditable.value,
          ),

          SelectSingleComponent(
            controller: controller.selectCabangCon,
            label: "select_branch".tr,
            editable: controller.isEditable.value,
          ),
        ],
        saveOnTap: controller.saveOnTap,
        cancelEditOnTap: () => controller.addValueInputFields(controller.model),
      ),
    );
  }
}
