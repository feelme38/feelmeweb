// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDTO _$AddressDTOFromJson(Map<String, dynamic> json) => AddressDTO(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddressDTOToJson(AddressDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'address': instance.address,
      'lat': instance.lat,
      'lon': instance.lon,
    };
