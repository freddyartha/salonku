import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';

import '../controllers/schedule_calendar_controller.dart';

class ScheduleCalendarView extends GetView<ScheduleCalendarController> {
  const ScheduleCalendarView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<DateTime> eventDates = [
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 5)),
      DateTime.now().add(Duration(days: 12)),
      DateTime.now().add(Duration(days: 15)),
      DateTime.now().add(Duration(days: 30)),
    ];
    return Scaffold(
      appBar: ReusableWidgets.generalAppBarWidget(
        title: "schedule_calendar".tr,
      ),
      body: SafeArea(
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
                  final hasEvent = eventDates.any(
                    (e) =>
                        e.year == date.year &&
                        e.month == date.month &&
                        e.day == date.day,
                  );

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
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isSelected == true
                                  ? AppColors.darkText
                                  : context.contrast,
                              shape: BoxShape.circle,
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

            final hasEvent = eventDates.any(
              (e) =>
                  e.year == selected.year &&
                  e.month == selected.month &&
                  e.day == selected.day,
            );

            if (hasEvent) {
              ReusableWidgets.notifBottomSheet(
                subtitle: "test",
                notifType: NotifType.success,
              );
            }
          },
        ),
      ),
    );
  }
}
