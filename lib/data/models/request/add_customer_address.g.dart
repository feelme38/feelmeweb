// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_customer_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCustomerAddressBody _$AddCustomerAddressBodyFromJson(
        Map<String, dynamic> json) =>
    AddCustomerAddressBody(
      json['customerId'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$AddCustomerAddressBodyToJson(
        AddCustomerAddressBody instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'address': instance.address,
    };
