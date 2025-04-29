// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModelsResponse _$DeviceModelsResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceModelsResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      worker_type: $enumDecode(_$WorkerTypeEnumMap, json['worker_type']),
    );

Map<String, dynamic> _$DeviceModelsResponseToJson(
        DeviceModelsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'worker_type': _$WorkerTypeEnumMap[instance.worker_type]!,
    };

const _$WorkerTypeEnumMap = {
  WorkerType.FULL: 'FULL',
  WorkerType.LITE: 'LITE',
};
