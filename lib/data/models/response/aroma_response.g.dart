// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aroma_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AromaResponse _$AromaResponseFromJson(Map<String, dynamic> json) =>
    AromaResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecodeNullable(_$AromaTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AromaResponseToJson(AromaResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AromaTypeEnumMap[instance.type],
    };

const _$AromaTypeEnumMap = {
  AromaType.CLASSIC: 'CLASSIC',
  AromaType.PREMIUM: 'PREMIUM',
  AromaType.LUXE: 'LUXE',
};
