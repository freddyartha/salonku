import 'package:flutter/services.dart';
import 'package:salonku/app/common/input_formatter.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = InputFormatter.currencyToDouble(newValue.text);
    String newText = InputFormatter.toCurrency(value);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  static FilteringTextInputFormatter allow = FilteringTextInputFormatter.allow(
    RegExp(r'^(\d+)|(,)?\.?\d{0,10}'),
  );
}
