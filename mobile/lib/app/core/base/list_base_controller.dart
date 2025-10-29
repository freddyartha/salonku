import 'dart:ui';

import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/base_controller.dart';

abstract class ListBaseController extends BaseController {
  final InputTextController searchController = InputTextController();

  Future<void> deleteData(dynamic Function() confirmOnTap) async {
    var r = await ReusableWidgets.confirmationBottomSheet(
      children: [
        TextComponent(
          value: "delete_confirmation".tr,
          textAlign: TextAlign.center,
        ),
      ],
    );

    if (r == true) {
      confirmOnTap();
    }
  }
}
