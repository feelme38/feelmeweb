import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_time.g.dart';

@JsonSerializable()
class LocalTime {
  final int? hour;
  final int? minute;
  final int? second;
  final int? nano;

  LocalTime({
    this.hour,
    this.minute,
    this.second,
    this.nano,
  });

  factory LocalTime.fromJson(Map<String, dynamic> json) =>
      _$LocalTimeFromJson(json);

  String toFormattedTime() {
    return DateFormat('HH:mm:ss').format(
      DateTime(0, 1, 1, hour ?? 0, minute ?? 0, second ?? 0),
    );
  }

  Map<String, dynamic> toJson() => _$LocalTimeToJson(this);
}
