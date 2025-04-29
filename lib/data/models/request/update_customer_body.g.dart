// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCustomerBody _$UpdateCustomerBodyFromJson(Map<String, dynamic> json) =>
    UpdateCustomerBody(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerName: json['ownerName'] as String,
      phone: json['phone'] as String,
      regionId: json['regionId'] as String,
    );

Map<String, dynamic> _$UpdateCustomerBodyToJson(UpdateCustomerBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerName': instance.ownerName,
      'phone': instance.phone,
      'regionId': instance.regionId,
    };
