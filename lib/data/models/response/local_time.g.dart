// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalTime _$LocalTimeFromJson(Map<String, dynamic> json) => LocalTime(
      hour: json['hour'] as int?,
      minute: json['minute'] as int?,
      second: json['second'] as int?,
      nano: json['nano'] as int?,
    );

Map<String, dynamic> _$LocalTimeToJson(LocalTime instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
      'second': instance.second,
      'nano': instance.nano,
    };
