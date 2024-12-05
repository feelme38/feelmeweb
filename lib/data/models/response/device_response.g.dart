// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) =>
    DeviceResponse(
      id: json['id'] as String,
      aroma: json['aroma'] == null
          ? null
          : AromaResponse.fromJson(json['aroma'] as Map<String, dynamic>),
      powerType: json['powerType'] as String?,
      model: json['model'] as String?,
      aromaVolume: (json['aromaVolume'] as num?)?.toDouble(),
      contract: json['contract'] as String?,
      place: json['place'] as String?,
      powerElementsCount: json['powerElementsCount'] as int?,
    );

Map<String, dynamic> _$DeviceResponseToJson(DeviceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aroma': instance.aroma,
      'powerType': instance.powerType,
      'model': instance.model,
      'aromaVolume': instance.aromaVolume,
      'contract': instance.contract,
      'place': instance.place,
      'powerElementsCount': instance.powerElementsCount,
    };
