// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_update_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteUpdateBody _$RouteUpdateBodyFromJson(Map<String, dynamic> json) =>
    RouteUpdateBody(
      json['routeId'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$RouteUpdateBodyToJson(RouteUpdateBody instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'status': instance.status,
    };
