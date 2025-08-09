// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModelResponse _$DeviceModelResponseFromJson(Map<String, dynamic> json) =>
    DeviceModelResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      worker_type:
          $enumDecodeNullable(_$WorkerTypeEnumMap, json['worker_type']),
    );

Map<String, dynamic> _$DeviceModelResponseToJson(
        DeviceModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'worker_type': _$WorkerTypeEnumMap[instance.worker_type],
    };

const _$WorkerTypeEnumMap = {
  WorkerType.FULL: 'FULL',
  WorkerType.LITE: 'LITE',
};
