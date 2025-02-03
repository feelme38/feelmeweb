// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckListInfoResponse _$CheckListInfoResponseFromJson(
        Map<String, dynamic> json) =>
    CheckListInfoResponse(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : LocalDateTime.fromJson(json['createdAt'] as Map<String, dynamic>),
      pdfUrl: json['pdfUrl'] as String?,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckListInfoResponseToJson(
        CheckListInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'pdfUrl': instance.pdfUrl,
      'customer': instance.customer,
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };

LocalDateTime _$LocalDateTimeFromJson(Map<String, dynamic> json) =>
    LocalDateTime(
      date: LocalDate.fromJson(json['date'] as Map<String, dynamic>),
      time: json['time'] == null
          ? null
          : LocalTime.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalDateTimeToJson(LocalDateTime instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      ownerName: json['ownerName'] as String?,
      devices:
          (json['devices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'ownerName': instance.ownerName,
      'devices': instance.devices,
      'addresses': instance.addresses,
    };
