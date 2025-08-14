// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      ownerName: json['ownerName'] as String?,
      preferredStartTime: json['preferredStartTime'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => DeviceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      region: json['region'] == null
          ? null
          : RegionResponse.fromJson(json['region'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'ownerName': instance.ownerName,
      'preferredStartTime': instance.preferredStartTime,
      'addresses': instance.addresses,
      'devices': instance.devices,
      'lat': instance.lat,
      'lon': instance.lon,
      'region': instance.region,
    };
