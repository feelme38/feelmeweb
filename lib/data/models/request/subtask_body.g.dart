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
      json['volumeFormula'] as String,
      json['typeId'] as String,
      id: json['id'] as String?,
      addressId: json['addressId'] as String?,
      subtaskStatus: json['subtaskStatus'] as String?,
    );

Map<String, dynamic> _$SubtaskBodyToJson(SubtaskBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'addressId': instance.addressId,
      'subtaskStatus': instance.subtaskStatus,
      'deviceId': instance.deviceId,
      'comment': instance.comment,
      'expectedAromaId': instance.expectedAromaId,
      'expectedAromaVolume': instance.expectedAromaVolume,
      'volumeFormula': instance.volumeFormula,
      'typeId': instance.typeId,
    };
