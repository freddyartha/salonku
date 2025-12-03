import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

class IncomeExpenseListModel {
  int id;
  double nominal;
  String type;
  String? keterangan;
  DateTime? createdAt;

  IncomeExpenseListModel({
    required this.id,
    required this.nominal,
    required this.type,
    this.keterangan,
    this.createdAt,
  });

  static IncomeExpenseListModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static IncomeExpenseListModel fromDynamic(dynamic dynamicData) {
    return IncomeExpenseListModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nominal: InputFormatter.dynamicToDouble(dynamicData['nominal']) ?? 0,
      type: dynamicData['type'] ?? '',
      keterangan: dynamicData['keterangan'],
      createdAt: InputFormatter.dynamicToDateTime(dynamicData['created_at']),
    );
  }
}
