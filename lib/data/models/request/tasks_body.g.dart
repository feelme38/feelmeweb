// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksBody _$TasksBodyFromJson(Map<String, dynamic> json) => TasksBody(
      name: json['name'] as String,
      clientId: json['clientId'] as String,
      addressId: json['addressId'] as String,
      taskStatus: json['taskStatus'] as String?,
      subtasks: (json['subtasks'] as List<dynamic>)
          .map((e) => SubtaskBody.fromJson(e as Map<String, dynamic>))
          .toList(),
      visitTimeFrom: json['visitTimeFrom'] == null
          ? null
          : DateTime.parse(json['visitTimeFrom'] as String),
      visitTimeTo: json['visitTimeTo'] == null
          ? null
          : DateTime.parse(json['visitTimeTo'] as String),
      comment: json['comment'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TasksBodyToJson(TasksBody instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'clientId': instance.clientId,
      'addressId': instance.addressId,
      'taskStatus': instance.taskStatus,
      'visitTimeFrom': instance.visitTimeFrom?.toIso8601String(),
      'visitTimeTo': instance.visitTimeTo?.toIso8601String(),
      'comment': instance.comment,
      'subtasks': instance.subtasks,
    };
