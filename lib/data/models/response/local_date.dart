
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
part 'local_date.g.dart';

@JsonSerializable()
class LocalDate {
  final int year;
  final int month;
  final int day;

  LocalDate({
    required this.year,
    required this.month,
    required this.day,
  });

  factory LocalDate.fromJson(Map<String, dynamic> json) => _$LocalDateFromJson(json);

  String? toDateTime() {
    return DateFormat('dd.MM.yyyy').format(DateTime(year, month, day));
  }
}