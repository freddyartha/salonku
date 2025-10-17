import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salonku/app/common/lang/translation_service.dart';

class InputFormatter {
  static String displayDate(
    DateTime? date, {
    bool mini = false,
    bool showDayName = false,
  }) {
    if (date == null) return "-";
    String format = "dd MMMM yyyy";

    if (mini) format = "dd MMM yyyy";
    if (showDayName) format = "EEEE, $format";

    var dateFormat = DateFormat(format, TranslationService.locale.languageCode);
    return dateFormat.format(date);
  }

  static String displayDateRange(
    DateTimeRange? dateRange, {
    bool mini = false,
    bool britishDateFormat = false,
    bool showDayName = false,
  }) {
    if (dateRange == null) return "-";

    String format = "dd MMMM yyyy";

    if (mini) format = "dd MMM yyyy";
    if (britishDateFormat) format = "dd/MM/yyyy";
    if (showDayName) format = "EEEE, $format";

    var dateFormat = DateFormat(format);
    String start = dateFormat.format(dateRange.start);
    String end = dateFormat.format(dateRange.end);

    return "$start - $end";
  }

  static String? dateToString(DateTime? date) {
    if (date == null) return null;
    var dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(date);
  }

  String mataUangID(dynamic nominal) {
    return NumberFormat.currency(
      locale: 'id',
      decimalDigits: 0,
      symbol: "Rp",
    ).format(nominal);
  }

  static String tanggalAngka(DateTime dateTime, {String separator = "/"}) {
    return DateFormat("dd${separator}MM${separator}yyyy").format(dateTime);
  }

  static String? timeToString(
    TimeOfDay? time, {
    bool twentyFour = true,
    bool millisecond = true,
  }) {
    if (time == null) return null;
    var hour = twentyFour
        ? time.hour
        : (time.hour > 12 ? time.hour - 12 : time.hour);
    if (hour == 0) {
      hour = 12;
    }
    var minute = time.minute;
    var strHour = hour > 9 ? '$hour' : '0$hour';
    var strMinute = minute > 9 ? '$minute' : '0$minute';
    var r = "$strHour:$strMinute";
    if (millisecond) {
      r += ":00";
    }
    return twentyFour ? r : '$r ${time.hour > 12 ? 'PM' : 'AM'}';
  }

  static String? dateTimeOfDayToString(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return null;
    return "${dateToString(date)}T${timeToString(time)}";
  }

  static String displayTime(TimeOfDay? time, {bool twentyFour = true}) {
    if (time == null) return "-";
    var hour = twentyFour
        ? time.hour
        : (time.hour > 12 ? time.hour - 12 : time.hour);
    if (hour == 0 && !twentyFour) {
      hour = 12;
    }
    var minute = time.minute;
    var strHour = hour > 9 ? '$hour' : '0$hour';
    var strMinute = minute > 9 ? '$minute' : '0$minute';
    var r = "$strHour:$strMinute";
    return twentyFour ? r : '$r ${time.hour > 12 ? 'PM' : 'AM'}';
  }

  static DateTime? stringToDateTime(String? stringDate) {
    if (stringDate == null) return null;
    try {
      return DateTime.parse(stringDate);
    } catch (ex) {
      return null;
    }
  }

  static Timestamp? stringToTimestamp(String? stringDate) {
    if (stringDate == null) return null;
    try {
      var dateValue = stringToDateTime(stringDate);
      if (dateValue != null) {
        return Timestamp.fromDate(dateValue);
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  static TimeOfDay? stringToTime(String? time) {
    if (time == null) return null;
    final add = time.indexOf("PM") > 0 ? 12 : 0;
    final r = TimeOfDay(
      hour: int.parse(time.split(":")[0]) + add,
      minute: int.parse(time.split(":")[1].split(' ')[0]),
    );
    return r;
  }

  static Timestamp? timeOfDayToTimestamp(TimeOfDay? time) {
    if (time == null) return null;
    final now = DateTime.now();

    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    return Timestamp.fromDate(dateTime);
  }

  static String toCurrency(double? value) {
    if (value == null) return "";
    final numberFormat = NumberFormat.currency(
      locale: TranslationService.locale.languageCode,
      symbol: '',
      decimalDigits: 0,
    );
    return numberFormat.format(value);
  }

  static double currencyToDouble(String? value) {
    if (value == null) return 0;
    value = TranslationService.locale == Locale("id", "ID")
        ? value.replaceAll(".", "")
        : value.replaceAll(",", "");
    return double.parse(value);
  }

  static double? dynamicToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value);
  }

  static DateTime? dynamicToDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) return stringToDateTime(value.toString());
    return DateTime.tryParse(value);
  }

  static Timestamp? dynamicToTimestamp(dynamic value) {
    // print(value);
    if (value == null) return null;
    if (value is Timestamp) return value;
    if (value is DateTime) return Timestamp.fromDate(value);
    if (value is String) return stringToTimestamp(value);
    return null;
  }

  static int? dynamicToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value);
  }

  static bool? dynamicToBool(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return value == 1
          ? true
          : value == 0
          ? false
          : null;
    }
    if (value is String) {
      return (value.toUpperCase() == "TRUE" || value.toUpperCase() == "1")
          ? true
          : (value.toUpperCase() == "FALSE" || value.toUpperCase() == "0")
          ? false
          : null;
    }
    return value;
  }

  static String? dynamicToPhoneNumber(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      if (value.startsWith('+62')) {
        return value;
      } else if (value.startsWith('0')) {
        return '+62${value.substring(1)}';
      } else {
        return '+62$value';
      }
    }

    return value.toString();
  }

  static String? displayPhoneNumber(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      if (value.startsWith('0')) {
        return value.substring(1);
      } else if (value.startsWith('+62')) {
        return value.substring(3);
      } else {
        return value;
      }
    }

    return value.toString();
  }

  static String titleToCamelCase(String input) {
    input = input.trim().toLowerCase();
    if (!input.contains("_") && !input.contains(" ")) {
      return input;
    }

    List<String> parts;
    if (input.contains("_")) {
      parts = input.split('_');
    } else {
      parts = input.split(' ');
    }

    return parts.first +
        parts.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
  }

  static int getWeeksInCurrentMonth({DateTime? date}) {
    final now = date ?? DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    int firstWeek = _weekNumber(firstDay);
    int lastWeek = _weekNumber(lastDay);

    return lastWeek - firstWeek + 1;
  }

  static int _weekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1;
    final startOfFirstWeek = firstDayOfYear.subtract(
      Duration(days: daysOffset),
    );
    final diff = date.difference(startOfFirstWeek).inDays;
    return (diff / 7).ceil();
  }

  static int getWeekOfMonth(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    int firstWeekday = firstDayOfMonth.weekday;
    int diff = date.day + firstWeekday - 2;

    return (diff / 7).ceil();
  }
}
