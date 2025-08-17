import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';

class ChecklistsHelper {
  static String pluralizeAttachments(int count) {
    final lastTwoDigits = count % 100;
    final lastDigit = count % 10;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
      return '$count файлов';
    }

    switch (lastDigit) {
      case 1:
        return '$count файл';
      case 2:
      case 3:
      case 4:
        return '$count файла';
      default:
        return '$count файлов';
    }
  }

  static String formatWorkSchedule(DeviceWorkSchedule? schedule) {
    if (schedule == null || (schedule.workModes ?? []).isEmpty) {
      return "-";
    }

    final buffer = StringBuffer();

    for (var i = 0; i < schedule.workModes!.length; i++) {
      final mode = schedule.workModes![i];
      buffer.writeln("Режим ${i + 1}:");

      if (mode.intensity != null) {
        buffer.writeln("\t\t\t\tИнтенсивность: ${mode.intensity}%");
      } else {
        buffer.writeln("\t\t\t\tРабота: ${mode.tWork} мин");
        buffer.writeln("\t\t\t\tПауза: ${mode.tPause} мин");
        buffer.writeln(
            "\t\t\t\tВремя работы: ${mode.tStart}:00 - ${mode.tEnd}:00");
      }

      if (mode.workDays.isNotEmpty) {
        buffer.writeln(
            "\t\t\t\tДни: ${mode.workDays.map((e) => e.displayName).toList().join(", ")}");
      }

      if (i != schedule.workModes!.length - 1) {
        buffer.writeln(""); // разделитель между режимами
      }
    }

    return buffer.toString().trim();
  }
}
