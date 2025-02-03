// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksBody _$TasksBodyFromJson(Map<String, dynamic> json) => TasksBody(
      json['name'] as String,
      DateTime.parse(json['visitTime'] as String),
      json['typeId'] as String,
      json['clientId'] as String,
      json['addressId'] as String,
      (json['subtasks'] as List<dynamic>)
          .map((e) => SubtaskBody.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TasksBodyToJson(TasksBody instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'visitTime': instance.visitTime.toIso8601String(),
      'typeId': instance.typeId,
      'clientId': instance.clientId,
      'addressId': instance.addressId,
      'subtasks': instance.subtasks,
    };
