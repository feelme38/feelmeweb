// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteBody _$RouteBodyFromJson(Map<String, dynamic> json) => RouteBody(
      json['userId'] as String,
      (json['tasks'] as List<dynamic>)
          .map((e) => TasksBody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteBodyToJson(RouteBody instance) => <String, dynamic>{
      'userId': instance.userId,
      'tasks': instance.tasks,
    };
