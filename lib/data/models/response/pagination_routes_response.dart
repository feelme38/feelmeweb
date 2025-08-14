import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_routes_response.g.dart';

@JsonSerializable()
class PaginationRoutesResponse {
  final List<RouteResponse> data;
  final Meta meta;

  PaginationRoutesResponse({
    required this.data,
    required this.meta,
  });

  factory PaginationRoutesResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationRoutesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationRoutesResponseToJson(this);
}

@JsonSerializable()
class Meta {
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
