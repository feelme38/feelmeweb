// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_device_model_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeviceModelBody _$CreateDeviceModelBodyFromJson(
        Map<String, dynamic> json) =>
    CreateDeviceModelBody(
      name: json['name'] as String,
      worker_type: $enumDecode(_$WorkerTypeEnumMap, json['worker_type']),
    );

Map<String, dynamic> _$CreateDeviceModelBodyToJson(
        CreateDeviceModelBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'worker_type': _$WorkerTypeEnumMap[instance.worker_type]!,
    };

const _$WorkerTypeEnumMap = {
  WorkerType.FULL: 'FULL',
  WorkerType.LITE: 'LITE',
};
