import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/texts/two_row_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/schedule_calendar_controller.dart';

class ScheduleCalendarView extends GetView<ScheduleCalendarController> {
  const ScheduleCalendarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "schedule_calendar".tr,
      ),
      body: SafeArea(
        child: GetBuilder<ScheduleCalendarController>(
          builder: (controller) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >
                    scrollInfo.metrics.maxScrollExtent - 200) {
                  print("Mau sampai bawah, bisa load data");
                }
                return false;
              },
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  dayBuilder:
                      ({
                        required date,
                        decoration,
                        isDisabled,
                        isSelected,
                        isToday,
                        textStyle,
                      }) {
                        final hasEvent = controller.model.any(
                          (e) =>
                              e.tanggalJam.year == date.year &&
                              e.tanggalJam.month == date.month &&
                              e.tanggalJam.day == date.day,
                        );

                        final eventCount = controller.model
                            .where(
                              (e) =>
                                  e.tanggalJam.year == date.year &&
                                  e.tanggalJam.month == date.month &&
                                  e.tanggalJam.day == date.day,
                            )
                            .length;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Tanggal biasa
                            isSelected == true
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: context.contrast,
                                      shape: BoxShape.circle,
                                    ),
                                    child: TextComponent(
                                      value: '${date.day}',
                                      fontColor: AppColors.darkText,
                                      fontWeight: FontWeights.semiBold,
                                      fontSize: FontSizes.h6,
                                      height: 1,
                                    ),
                                  )
                                : TextComponent(
                                    value: '${date.day}',
                                    fontColor: context.text,
                                    fontWeight: FontWeights.regular,
                                    height: 1,
                                  ),
                            // Titik event di bawah tanggal
                            if (hasEvent)
                              Positioned(
                                bottom: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                    eventCount,
                                    (index) => Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 1.5,
                                      ),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: isSelected == true
                                            ? AppColors.darkText
                                            : context.contrast,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                  hideScrollViewTopHeader: true,
                  weekdayLabels:
                      TranslationService.locale == TranslationService.localeEn
                      ? ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      : ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Ming"],
                  monthTextStyle: TextStyle(
                    fontWeight: FontWeights.semiBold,
                    color: context.text,
                  ),
                  centerAlignModePicker: true,
                  controlsTextStyle: TextStyle(
                    fontWeight: FontWeights.semiBold,
                    color: context.text,
                    fontSize: FontSizes.h6,
                  ),
                  weekdayLabelTextStyle: TextStyle(
                    fontWeight: FontWeights.semiBold,
                    color: context.text,
                  ),
                  dayTextStyle: TextStyle(
                    fontWeight: FontWeights.regular,
                    color: context.text,
                  ),
                  selectedDayHighlightColor: context.contrast,
                  selectedDayTextStyle: TextStyle(
                    fontWeight: FontWeights.semiBold,
                    color: context.text,
                  ),
                  calendarType: CalendarDatePicker2Type.single,
                  calendarViewMode: CalendarDatePicker2Mode.scroll,
                ),
                value: [DateTime.now()],

                onValueChanged: (dates) {
                  if (dates.isEmpty) return;

                  final selected = dates.first;

                  final hasEvent = controller.model.any(
                    (e) =>
                        e.tanggalJam.year == selected.year &&
                        e.tanggalJam.month == selected.month &&
                        e.tanggalJam.day == selected.day,
                  );

                  final eventsToday = controller.model
                      .where(
                        (e) =>
                            e.tanggalJam.year == selected.year &&
                            e.tanggalJam.month == selected.month &&
                            e.tanggalJam.day == selected.day,
                      )
                      .toList();

                  if (hasEvent) {
                    ReusableWidgets.customBottomSheet(
                      title: "Detail Booking",
                      children: eventsToday
                          .map(
                            (event) => Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Radiuses.large),
                                ),
                                border: Border.all(color: context.contrast),
                              ),
                              child: Column(
                                children: [
                                  TwoRowComponent(
                                    dataPadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    titlePadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    title: "time".tr,
                                    titleWidth: 0.3,
                                    paddingWidth: 30,
                                    titleFontWeight: FontWeights.semiBold,
                                    data:
                                        InputFormatter.displayTimeFromDateTime(
                                          event.tanggalJam,
                                        ),
                                  ),
                                  TwoRowComponent(
                                    titleWidth: 0.3,
                                    dataPadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    titlePadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    title: "client_name".tr,
                                    paddingWidth: 30,
                                    titleFontWeight: FontWeights.semiBold,
                                    data: event.client?.nama,
                                  ),
                                  TwoRowComponent(
                                    titleWidth: 0.3,
                                    dataPadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    titlePadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    title: "client_phone".tr,
                                    paddingWidth: 30,
                                    titleFontWeight: FontWeights.semiBold,
                                    data: event.client?.phone,
                                  ),
                                  TwoRowComponent(
                                    titleWidth: 0.3,
                                    dataPadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    titlePadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    title: "client_email".tr,
                                    paddingWidth: 30,
                                    titleFontWeight: FontWeights.semiBold,
                                    data: event.client?.email,
                                  ),
                                  TwoRowComponent(
                                    titleWidth: 0.3,
                                    dataPadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    titlePadding: EdgeInsetsGeometry.only(
                                      bottom: 5,
                                    ),
                                    title: "catatan".tr,
                                    paddingWidth: 30,
                                    titleFontWeight: FontWeights.semiBold,
                                    data: event.catatan,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
