// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_routes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationRoutesResponse _$PaginationRoutesResponseFromJson(
        Map<String, dynamic> json) =>
    PaginationRoutesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => RouteResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationRoutesResponseToJson(
        PaginationRoutesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      total: json['total'] as int,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
    };
