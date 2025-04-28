// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModelResponse _$DeviceModelResponseFromJson(Map<String, dynamic> json) =>
    DeviceModelResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      workerType: json['workerType'] as String,
    );

Map<String, dynamic> _$DeviceModelResponseToJson(
        DeviceModelResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'workerType': instance.workerType,
    };
