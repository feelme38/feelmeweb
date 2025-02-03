// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aroma _$AromaFromJson(Map<String, dynamic> json) => Aroma(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AromaToJson(Aroma instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

AromaQuantity _$AromaQuantityFromJson(Map<String, dynamic> json) =>
    AromaQuantity(
      aroma: json['aroma'] == null
          ? null
          : Aroma.fromJson(json['aroma'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AromaQuantityToJson(AromaQuantity instance) =>
    <String, dynamic>{
      'aroma': instance.aroma,
      'quantity': instance.quantity,
    };

DeviceAroma _$DeviceAromaFromJson(Map<String, dynamic> json) => DeviceAroma(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DeviceAromaToJson(DeviceAroma instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String?,
      powerType: json['powerType'] as String?,
      model: json['model'] as String?,
      aromaVolume: (json['aromaVolume'] as num?)?.toDouble(),
      contract: json['contract'] as String?,
      place: json['place'] as String?,
      aroma: json['aroma'] == null
          ? null
          : DeviceAroma.fromJson(json['aroma'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'powerType': instance.powerType,
      'model': instance.model,
      'aromaVolume': instance.aromaVolume,
      'contract': instance.contract,
      'place': instance.place,
      'aroma': instance.aroma,
    };

InventoryResponse _$InventoryResponseFromJson(Map<String, dynamic> json) =>
    InventoryResponse(
      aromas: (json['aromas'] as List<dynamic>)
          .map((e) => AromaQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      instruments: (json['instruments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      materials:
          (json['materials'] as List<dynamic>).map((e) => e as String).toList(),
      other: (json['other'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InventoryResponseToJson(InventoryResponse instance) =>
    <String, dynamic>{
      'aromas': instance.aromas,
      'devices': instance.devices,
      'instruments': instance.instruments,
      'materials': instance.materials,
      'other': instance.other,
    };
