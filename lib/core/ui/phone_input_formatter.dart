
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Удаляем все символы, кроме цифр
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Удаляем ведущий "7" (если он есть), чтобы работать только с номером
    if (digits.startsWith('7')) {
      digits = digits.substring(1);
    }

    // Ограничиваем ввод до 10 цифр (без учета +7)
    if (digits.length > 10) {
      digits = digits.substring(0, 10);
    }

    // Форматируем номер
    String formatted = _applyMask(digits);

    // Корректируем позицию курсора
    int cursorPosition = _adjustCursorPosition(formatted, newValue.selection.baseOffset);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  String _applyMask(String digits) {
    final buffer = StringBuffer('+7');

    if (digits.isNotEmpty) buffer.write(' (');
    if (digits.length >= 1) buffer.write(digits.substring(0, digits.length.clamp(0, 3)));
    if (digits.length > 3) buffer.write(') ');
    if (digits.length > 3) buffer.write(digits.substring(3, digits.length.clamp(3, 6)));
    if (digits.length > 6) buffer.write('-');
    if (digits.length > 6) buffer.write(digits.substring(6, digits.length.clamp(6, 8)));
    if (digits.length > 8) buffer.write('-');
    if (digits.length > 8) buffer.write(digits.substring(8, digits.length.clamp(8, 10)));

    return buffer.toString();
  }

  int _adjustCursorPosition(String formatted, int baseOffset) {
    // Учитываем дополнительные символы маски
    int countNonDigit = formatted.substring(0, baseOffset).replaceAll(RegExp(r'\d'), '').length;
    return baseOffset + countNonDigit;
  }
}