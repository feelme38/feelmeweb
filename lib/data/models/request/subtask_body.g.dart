// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtaskBody _$SubtaskBodyFromJson(Map<String, dynamic> json) => SubtaskBody(
      json['customerId'] as String?,
      json['deviceId'] as String,
      json['comment'] as String,
      json['expectedAromaId'] as String,
      (json['expectedAromaVolume'] as num).toDouble(),
      json['estimatedCompletedTime'] as int,
    );

Map<String, dynamic> _$SubtaskBodyToJson(SubtaskBody instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'deviceId': instance.deviceId,
      'comment': instance.comment,
      'expectedAromaId': instance.expectedAromaId,
      'expectedAromaVolume': instance.expectedAromaVolume,
      'estimatedCompletedTime': instance.estimatedCompletedTime,
    };
