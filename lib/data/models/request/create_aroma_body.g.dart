// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_aroma_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAromaBody _$CreateAromaBodyFromJson(Map<String, dynamic> json) =>
    CreateAromaBody(
      name: json['name'] as String,
      type: $enumDecode(_$AromaTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CreateAromaBodyToJson(CreateAromaBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$AromaTypeEnumMap[instance.type]!,
    };

const _$AromaTypeEnumMap = {
  AromaType.CLASSIC: 'CLASSIC',
  AromaType.PREMIUM: 'PREMIUM',
  AromaType.LUXE: 'LUXE',
};
