// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveCustomerResponse _$ActiveCustomerResponseFromJson(
        Map<String, dynamic> json) =>
    ActiveCustomerResponse(
      customer: Client.fromJson(json['customer'] as Map<String, dynamic>),
      subtasks: (json['subtasks'] as List<dynamic>)
          .map((e) => Subtask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActiveCustomerResponseToJson(
        ActiveCustomerResponse instance) =>
    <String, dynamic>{
      'customer': instance.customer,
      'subtasks': instance.subtasks,
    };
