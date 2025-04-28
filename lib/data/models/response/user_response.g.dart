// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as String,
      json['name'] as String,
      json['profileUrl'] as String?,
      json['allTasksCount'] as int?,
      json['completedTasksCount'] as int?,
      $enumDecodeNullable(_$RouteStatusEnumMap, json['routeStatus']),
      json['routeId'] as String?,
      json['activeTaskId'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileUrl': instance.profileUrl,
      'allTasksCount': instance.allTasksCount,
      'completedTasksCount': instance.completedTasksCount,
      'routeStatus': _$RouteStatusEnumMap[instance.routeStatus],
      'routeId': instance.routeId,
      'activeTaskId': instance.activeTaskId,
    };

const _$RouteStatusEnumMap = {
  RouteStatus.ASSIGNED: 'ASSIGNED',
  RouteStatus.STARTED: 'STARTED',
  RouteStatus.PAUSED: 'PAUSED',
  RouteStatus.FINISHED: 'FINISHED',
  RouteStatus.CANCELED: 'CANCELED',
};
