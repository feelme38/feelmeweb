// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_aroma_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAromaBody _$UpdateAromaBodyFromJson(Map<String, dynamic> json) =>
    UpdateAromaBody(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$AromaTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$UpdateAromaBodyToJson(UpdateAromaBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AromaTypeEnumMap[instance.type]!,
    };

const _$AromaTypeEnumMap = {
  AromaType.CLASSIC: 'CLASSIC',
  AromaType.PREMIUM: 'PREMIUM',
  AromaType.LUXE: 'LUXE',
};
