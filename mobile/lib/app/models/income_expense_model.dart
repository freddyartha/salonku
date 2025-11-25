import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

class IncomeExpenseModel {
  double totalIncome;
  double totalExpense;

  IncomeExpenseModel({required this.totalIncome, required this.totalExpense});

  static IncomeExpenseModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static IncomeExpenseModel fromDynamic(dynamic dynamicData) {
    return IncomeExpenseModel(
      totalIncome:
          InputFormatter.dynamicToDouble(dynamicData['total_income']) ?? 0,
      totalExpense:
          InputFormatter.dynamicToDouble(dynamicData['total_expense']) ?? 0,
    );
  }
}
