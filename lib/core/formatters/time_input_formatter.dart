import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Убираем всё, кроме цифр

    if (text.isEmpty) return newValue; // Разрешаем очистку поля

    String formattedText = '';

    if (text.length >= 2) {
      int hours = int.parse(text.substring(0, 2));
      if (hours > 23) hours = 23; // Ограничиваем часы

      formattedText =
          hours.toString().padLeft(2, '0'); // Дополняем ведущим нулем

      if (text.length > 2) {
        String minutePart = text.substring(2); // Временная строка для минут

        if (minutePart.length == 1) {
          // Если введена только одна цифра минут - пока не форматируем
          formattedText += ':$minutePart';
        } else {
          // Если введены две цифры минут - корректируем их
          int minutes = int.parse(minutePart.substring(0, 2));
          if (minutes > 59) minutes = 59;

          formattedText += ':${minutes.toString().padLeft(2, '0')}';
        }
      }
    } else {
      formattedText = text;
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
