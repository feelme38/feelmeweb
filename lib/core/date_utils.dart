import 'package:intl/intl.dart';

DateFormat ruDateTimeFormat = DateFormat("dd.MM.yyyy HH:mm");
DateFormat ruDateFormat = DateFormat("dd.MM.yyyy");
DateFormat timeFormat = DateFormat("HH:mm:ss");
DateFormat timeWithoutSecondsFormat = DateFormat("HH:mm");

class DateUtil {
  static String getLastDayAMonth() {
    final now = DateTime.now();
    final month = now.month;
    String monthStr = month < 10 ? '0$month' : '$month';
    final lastDay = DateTime(now.year, month + 1, 0).day;
    final year = now.year;
    return '$year-$monthStr-$lastDay';
  }

  static String getFirstDayAMonth() {
    final now = DateTime.now();
    String monthStr = (now.month) < 10 ? '0${now.month}' : '${now.month}';
    final year = now.year;
    return '$year-$monthStr-01';
  }

  static String formatToDDMMYYYY(String date) {
    return DateFormat(DateFormats.ddMMyyyy)
        .format(getUtcConverted(DateTime.parse(date)));
  }

  static String formatToMMYYYY(String date) {
    return DateFormat(DateFormats.MMyyyy)
        .format(getUtcConverted(DateTime.parse(date)));
  }

  static String formatToRuDateTime(String? input) {
    if (input == null) return '-';
    if (input.trim().isEmpty) return input;
    return ruDateTimeFormat.format(getUtcConverted(DateTime.parse(input)));
  }

  static String formatToRuDate(String? input) {
    if (input == null) return '-';
    if (input.trim().isEmpty) return input;
    var converted = DateTime.tryParse(input);
    if (converted == null) return '-';
    return ruDateFormat.format(converted);
  }

  static String formatToTime(String input, [bool withSeconds = false]) {
    if (input.trim().isEmpty) return input;
    return withSeconds
        ? timeFormat.format(getUtcConverted(DateTime.parse(input)))
        : timeWithoutSecondsFormat
            .format(getUtcConverted(DateTime.parse(input)));
  }

  static DateTime getUtcConverted(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day, date.hour, date.minute,
            date.second)
        .toLocal();
  }

  static String formatToYYYYMMDD(DateTime date) {
    return DateFormat(DateFormats.yyyyMMdd).format(date);
  }

  static String formatToYYYYMMDDTHHmmss(DateTime date) {
    return DateFormat(DateFormats.yyyyMMddTHHmmss).format(date);
  }

  static String formatToYYYYMMDDTHHmmssms(DateTime date) {
    return DateFormat(DateFormats.yyyyMMddTHHmmsszsssss).format(date);
  }

  static DateTime? parseTime(String timeText) {
    final timeRegex = RegExp(r'^\d{2}:\d{2}$');

    if (!timeRegex.hasMatch(timeText)) return null;

    final timeParts = timeText.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    if (hours > 23 || minutes > 59) return null; // Дополнительная проверка

    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hours, minutes);
  }

  static String toDateTime(DateTime? date) {
    if (date == null) return '-';
    return DateFormat(DateFormats.ddMMyyyy2)
        .format(DateTime(date.year, date.month, date.day));
  }
}

class DateFormats {
  DateFormats._();

  static const yyyyMMdd = 'yyyy-MM-dd';
  static const yyyyMMddTHHmmss = 'yyyy-MM-ddTHH:mm:ss';
  static const yyyyMMddTHHmmsszsssss = 'yyyy-MM-ddTHH:mm:ss.ssssss';
  static const ddMMyyyy = 'dd-MM-yyyy';
  static const ddMMyyyy2 = 'dd-MM-yyyy';
  static const MMyyyy = 'MM-yyyy';
  static const HHmm = 'HH:mm';
}
