import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/lang/translation_service.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:table_calendar/table_calendar.dart';

import 'input_box_component.dart';

class InputDatetimeController {
  late bool _required;
  final InputDatetimeType type;
  final DateTime? maxDate;
  late bool _isDialogFormat;
  late BuildContext _context;
  late Function(VoidCallback fn) setState;
  bool _isInit = false;

  DateTime? _date;
  DateTimeRange? _dateRange;
  TimeOfDay? _time;
  String? _errorMessage;

  InputDatetimeController({
    this.type = InputDatetimeType.date,
    this.maxDate,
    this.onChanged,
  });

  Function()? onChanged;

  set value(dynamic val) {
    if (val == null) {
      _date = null;
    } else if (val is DateTime) {
      _date = val;
    } else if (val is TimeOfDay) {
      _time = val;
    } else if (val is DateTimeRange) {
      _dateRange = val;
    } else if (val is Timestamp) {
      _date = InputFormatter.dynamicToDateTime(val);
    }
    if (_isInit) {
      setState(() {});
    }
  }

  dynamic get value {
    if (type == InputDatetimeType.date) {
      return _date;
    } else if (type == InputDatetimeType.time) {
      return _time;
    } else {
      return _dateRange;
    }
  }

  bool get isValid {
    setState(() {
      _errorMessage = null;
    });

    if (_required &&
        ((type == InputDatetimeType.date && _date == null) ||
            (type == InputDatetimeType.time && _time == null) ||
            (type == InputDatetimeType.dateRange && _dateRange == null))) {
      setState(() {
        _errorMessage = 'field_is_required'.tr;
      });
      return false;
    }
    return true;
  }

  void _onTab(bool editable) async {
    Get.focusScope!.unfocus();
    if (!editable) return;
    if (type == InputDatetimeType.date) {
      if (_isDialogFormat) {
        final DateTime? picked = await showDatePicker(
          context: _context,
          initialDate: _date ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: maxDate ?? DateTime.now().add(Duration(days: 3650)),
          locale: TranslationService.locale,
          cancelText: "cancel".tr,
          confirmText: "ok".tr,
          builder: (context, child) {
            return Theme(data: Theme.of(context), child: child!);
          },
        );
        if (picked != null && _date != picked) {
          setState(() {
            _date = picked;
          });
          isValid;
        }
      } else {
        final tmpSelectedDate = _date;
        bool? result = await ReusableWidgets.confirmationBottomSheet(
          title: "select_date".tr,
          children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return TableCalendar(
                  firstDay: DateTime(1900),
                  lastDay: maxDate ?? DateTime.now().add(Duration(days: 3650)),
                  focusedDay: _date ?? DateTime.now(),
                  locale: TranslationService.locale.languageCode,
                  selectedDayPredicate: (day) => isSameDay(_date, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _date = selectedDay;
                    });
                  },
                  availableCalendarFormats: {CalendarFormat.month: 'Month'},
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(color: Get.context?.text),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final isWeekend =
                          day.weekday == DateTime.saturday ||
                          day.weekday == DateTime.sunday;

                      return Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: isWeekend ? Colors.red : context.text,
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, day, focusedDay) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.contrast),
                      ),
                      alignment: Alignment.center,
                      child: TextComponent(value: '${day.day}'),
                    ),
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        decoration: BoxDecoration(
                          color: context.contrast,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: TextComponent(
                          value: '${day.day}',
                          fontColor: context.text,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );

        setState(() {
          if (result != true) {
            _date = tmpSelectedDate;
          }
          isValid;
        });
      }
    } else if (type == InputDatetimeType.time) {
      final TimeOfDay? picked = await showTimePicker(
        context: _context,
        initialTime: _time ?? TimeOfDay.now(),
        builder: (context, child) {
          return Theme(data: Theme.of(context), child: child!);
        },
      );
      if (picked != null && _time != picked) {
        setState(() {
          _time = picked;
        });
        isValid;
      }
    } else {
      final DateTimeRange? picked = await showDateRangePicker(
        context: _context,
        initialDateRange: _dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime.now().add(Duration(days: 3650)),
        builder: (context, child) {
          return Theme(data: Theme.of(context), child: child!);
        },
      );
      if (picked != null && _dateRange != picked) {
        setState(() {
          _dateRange = picked;
        });
        isValid;
      }
    }
    if (onChanged != null) {
      onChanged!();
    }
  }

  void _init(
    Function(VoidCallback fn) setStateX,
    BuildContext contextX,
    bool requiredX,
    bool isDialogFormat,
  ) {
    setState = setStateX;
    _context = contextX;
    _required = requiredX;
    _isDialogFormat = isDialogFormat;
    _isInit = true;
  }

  void clearOnTab() {
    setState(() {
      _date = null;
      _time = null;
      _dateRange = null;
    });
  }
}

enum InputDatetimeType { date, time, dateRange }

class InputDatetimeComponent extends StatefulWidget {
  final String? label;
  final String? placeHolder;
  final bool editable;
  final double? marginBottom;
  final bool required;
  final InputDatetimeController controller;
  final Radius? borderRadius;
  final String? description;
  final bool? boxChecked;
  final bool isDialogFormat;
  final Function()? checkBoxOnTab;

  const InputDatetimeComponent({
    super.key,
    this.label,
    this.placeHolder,
    this.marginBottom,
    required this.controller,
    this.editable = true,
    this.required = false,

    this.borderRadius,
    this.description,
    this.checkBoxOnTab,
    this.isDialogFormat = false,
    this.boxChecked,
  });

  @override
  State<InputDatetimeComponent> createState() => _InputDatetimeComponentState();
}

class _InputDatetimeComponentState extends State<InputDatetimeComponent> {
  @override
  void initState() {
    widget.controller._init(
      (fn) {
        if (mounted) {
          setState(fn);
        }
      },
      context,
      widget.required,
      widget.isDialogFormat,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBoxComponent(
          borderRadius:
              widget.borderRadius ?? Radius.circular(Radiuses.regular),
          label: widget.label,
          editable: widget.editable,
          isRequired: widget.required,
          icon:
              widget.controller.type == InputDatetimeType.date ||
                  widget.controller.type == InputDatetimeType.dateRange
              ? Icons.calendar_month_outlined
              : Icons.access_time_outlined,
          alowClear:
              widget.editable &&
              ((widget.controller.type == InputDatetimeType.date &&
                      widget.controller._date != null) ||
                  (widget.controller.type == InputDatetimeType.time &&
                      widget.controller._time != null) ||
                  (widget.controller.type == InputDatetimeType.dateRange &&
                      widget.controller._dateRange != null)),
          errorMessage: widget.controller._errorMessage,
          clearOnTab: widget.controller.clearOnTab,
          marginBottom: widget.marginBottom,
          onTap: () => widget.controller._onTab(widget.editable),
          childText: widget.controller.type == InputDatetimeType.date
              ? widget.controller._date == null
                    ? null
                    : InputFormatter.displayDate(widget.controller._date)
              : widget.controller.type == InputDatetimeType.dateRange
              ? widget.controller._dateRange == null
                    ? null
                    : InputFormatter.displayDateRange(
                        widget.controller._dateRange,
                      )
              : widget.controller._time?.format(context) ?? '',

          placeHolder: widget.placeHolder,
        ),
        if (widget.description != null) ...[
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.boxChecked != null)
                InkWell(
                  onTap: widget.checkBoxOnTab,
                  child: widget.boxChecked!
                      ? Icon(Icons.check_box_rounded, color: context.primary)
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: context.primary,
                        ),
                ),
              Flexible(child: TextComponent(value: widget.description)),
            ],
          ),
          SizedBox(height: 15),
        ],
      ],
    );
  }
}
