// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_device_model_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDeviceModelBody _$UpdateDeviceModelBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateDeviceModelBody(
      id: json['id'] as String,
      name: json['name'] as String,
      worker_type: $enumDecode(_$WorkerTypeEnumMap, json['worker_type']),
    );

Map<String, dynamic> _$UpdateDeviceModelBodyToJson(
        UpdateDeviceModelBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'worker_type': _$WorkerTypeEnumMap[instance.worker_type]!,
    };

const _$WorkerTypeEnumMap = {
  WorkerType.FULL: 'FULL',
  WorkerType.LITE: 'LITE',
};
