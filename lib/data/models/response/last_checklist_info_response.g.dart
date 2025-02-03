// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_checklist_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastCheckListInfoResponse _$LastCheckListInfoResponseFromJson(
        Map<String, dynamic> json) =>
    LastCheckListInfoResponse(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : LocalDate.fromJson(json['createdAt'] as Map<String, dynamic>),
      checklistAroma: ChecklistAroma.fromJson(
          json['checklistAroma'] as Map<String, dynamic>),
      deviceLocation: json['deviceLocation'] as String?,
      deviceWorkSchedule: json['deviceWorkSchedule'] == null
          ? null
          : DeviceWorkSchedule.fromJson(
              json['deviceWorkSchedule'] as Map<String, dynamic>),
      deviceId: json['deviceId'] as String?,
      deviceModel: json['deviceModel'] as String?,
      contract: json['contract'] as String?,
    );

Map<String, dynamic> _$LastCheckListInfoResponseToJson(
        LastCheckListInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'checklistAroma': instance.checklistAroma,
      'deviceWorkSchedule': instance.deviceWorkSchedule,
      'deviceId': instance.deviceId,
      'deviceModel': instance.deviceModel,
      'contract': instance.contract,
      'deviceLocation': instance.deviceLocation,
    };

ChecklistAroma _$ChecklistAromaFromJson(Map<String, dynamic> json) =>
    ChecklistAroma(
      json['newAromaId'] as String?,
      json['newAromaName'] as String?,
      volumeMl: (json['volumeMl'] as num).toDouble(),
    );

Map<String, dynamic> _$ChecklistAromaToJson(ChecklistAroma instance) =>
    <String, dynamic>{
      'newAromaId': instance.newAromaId,
      'volumeMl': instance.volumeMl,
      'newAromaName': instance.newAromaName,
    };

DeviceWorkSchedule _$DeviceWorkScheduleFromJson(Map<String, dynamic> json) =>
    DeviceWorkSchedule(
      json['duration'] as int?,
      type: json['type'] as String,
      workModes: (json['workModes'] as List<dynamic>?)
          ?.map((e) => WorkMode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceWorkScheduleToJson(DeviceWorkSchedule instance) =>
    <String, dynamic>{
      'type': instance.type,
      'duration': instance.duration,
      'workModes': instance.workModes,
    };

WorkMode _$WorkModeFromJson(Map<String, dynamic> json) => WorkMode(
      tWork: json['tWork'] as int,
      tPause: json['tPause'] as int,
      tStart: json['tStart'] as int,
      tEnd: json['tEnd'] as int,
      workDays: (json['workDays'] as List<dynamic>)
          .map((e) => $enumDecode(_$WeekDayEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$WorkModeToJson(WorkMode instance) => <String, dynamic>{
      'tWork': instance.tWork,
      'tPause': instance.tPause,
      'tStart': instance.tStart,
      'tEnd': instance.tEnd,
      'workDays': instance.workDays.map((e) => _$WeekDayEnumMap[e]!).toList(),
    };

const _$WeekDayEnumMap = {
  WeekDay.MONDAY: 'MONDAY',
  WeekDay.TUESDAY: 'TUESDAY',
  WeekDay.WEDNESDAY: 'WEDNESDAY',
  WeekDay.THURSDAY: 'THURSDAY',
  WeekDay.FRIDAY: 'FRIDAY',
  WeekDay.SATURDAY: 'SATURDAY',
  WeekDay.SUNDAY: 'SUNDAY',
};
