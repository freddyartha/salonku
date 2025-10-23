import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

class SalonSummaryModel {
  int jumlahCabang;
  int jumlahStaff;

  SalonSummaryModel({required this.jumlahCabang, required this.jumlahStaff});

  static SalonSummaryModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static SalonSummaryModel fromDynamic(dynamic dynamicData) {
    return SalonSummaryModel(
      jumlahCabang:
          InputFormatter.dynamicToInt(dynamicData['jumlah_cabang']) ?? 0,
      jumlahStaff:
          InputFormatter.dynamicToInt(dynamicData['jumlah_staff']) ?? 0,
    );
  }
}
