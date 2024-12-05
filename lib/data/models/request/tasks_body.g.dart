// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksBody _$TasksBodyFromJson(Map<String, dynamic> json) => TasksBody(
      json['name'] as String,
      json['typeId'] as String,
      json['clientId'] as String,
      (json['subtasks'] as List<dynamic>)
          .map((e) => SubtaskBody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksBodyToJson(TasksBody instance) => <String, dynamic>{
      'name': instance.name,
      'typeId': instance.typeId,
      'clientId': instance.clientId,
      'subtasks': instance.subtasks,
    };
