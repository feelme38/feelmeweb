// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_customer_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomerBody _$CreateCustomerBodyFromJson(Map<String, dynamic> json) =>
    CreateCustomerBody(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$CreateCustomerBodyToJson(CreateCustomerBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };
