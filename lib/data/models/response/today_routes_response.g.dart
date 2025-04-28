// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_routes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayRouteResponse _$TodayRouteResponseFromJson(Map<String, dynamic> json) =>
    TodayRouteResponse(
      id: json['id'] as String?,
      routeStatus: json['routeStatus'] as String?,
      allTasksCount: json['allTasksCount'] as int?,
      completedTasksCount: json['completedTasksCount'] as int?,
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TodayRouteTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      engineer: json['engineer'] == null
          ? null
          : TodayRouteEngineer.fromJson(
              json['engineer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodayRouteResponseToJson(TodayRouteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeStatus': instance.routeStatus,
      'allTasksCount': instance.allTasksCount,
      'completedTasksCount': instance.completedTasksCount,
      'tasks': instance.tasks,
      'engineer': instance.engineer,
    };

TodayRouteEngineer _$TodayRouteEngineerFromJson(Map<String, dynamic> json) =>
    TodayRouteEngineer(
      lastLat: (json['lastLat'] as num?)?.toDouble(),
      lastLon: (json['lastLon'] as num?)?.toDouble(),
      id: json['id'] as String?,
      name: json['name'] as String?,
      settings: json['settings'] == null
          ? null
          : TodayRouteEngineerSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodayRouteEngineerToJson(TodayRouteEngineer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'settings': instance.settings,
      'lastLat': instance.lastLat,
      'lastLon': instance.lastLon,
    };

TodayRouteEngineerSettings _$TodayRouteEngineerSettingsFromJson(
        Map<String, dynamic> json) =>
    TodayRouteEngineerSettings(
      wikiUrl: json['wikiUrl'] as String?,
    );

Map<String, dynamic> _$TodayRouteEngineerSettingsToJson(
        TodayRouteEngineerSettings instance) =>
    <String, dynamic>{
      'wikiUrl': instance.wikiUrl,
    };

TodayRouteTask _$TodayRouteTaskFromJson(Map<String, dynamic> json) =>
    TodayRouteTask(
      id: json['id'] as String?,
      name: json['name'] as String?,
      taskType: json['taskType'] == null
          ? null
          : TodayRouteTaskType.fromJson(
              json['taskType'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : TodayRouteClient.fromJson(json['client'] as Map<String, dynamic>),
      taskStatus: json['taskStatus'] as String?,
      completedTime: json['completedTime'] as int?,
      address: json['address'] == null
          ? null
          : TodayRouteAddress.fromJson(json['address'] as Map<String, dynamic>),
      subtasks: json['subtasks'] as List<dynamic>?,
    );

Map<String, dynamic> _$TodayRouteTaskToJson(TodayRouteTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taskType': instance.taskType,
      'client': instance.client,
      'taskStatus': instance.taskStatus,
      'completedTime': instance.completedTime,
      'address': instance.address,
      'subtasks': instance.subtasks,
    };

TodayRouteTaskType _$TodayRouteTaskTypeFromJson(Map<String, dynamic> json) =>
    TodayRouteTaskType(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TodayRouteTaskTypeToJson(TodayRouteTaskType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

TodayRouteClient _$TodayRouteClientFromJson(Map<String, dynamic> json) =>
    TodayRouteClient(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      ownerName: json['ownerName'] as String?,
      devices: json['devices'] as List<dynamic>?,
      addresses: json['addresses'] as List<dynamic>?,
    );

Map<String, dynamic> _$TodayRouteClientToJson(TodayRouteClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'ownerName': instance.ownerName,
      'devices': instance.devices,
      'addresses': instance.addresses,
    };

TodayRouteAddress _$TodayRouteAddressFromJson(Map<String, dynamic> json) =>
    TodayRouteAddress(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TodayRouteAddressToJson(TodayRouteAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
