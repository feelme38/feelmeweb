// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksBody _$TasksBodyFromJson(Map<String, dynamic> json) => TasksBody(
      name: json['name'] as String,
      clientId: json['clientId'] as String,
      addressId: json['addressId'] as String,
      subtasks: (json['subtasks'] as List<dynamic>)
          .map((e) => SubtaskBody.fromJson(e as Map<String, dynamic>))
          .toList(),
      visitDateTime: json['visitDateTime'] == null
          ? null
          : DateTime.parse(json['visitDateTime'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TasksBodyToJson(TasksBody instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'clientId': instance.clientId,
      'addressId': instance.addressId,
      'visitDateTime': instance.visitDateTime?.toIso8601String(),
      'subtasks': instance.subtasks,
    };
