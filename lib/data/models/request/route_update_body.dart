import 'package:json_annotation/json_annotation.dart';
part 'route_update_body.g.dart';

@JsonSerializable()
class RouteUpdateBody {
  final String routeId;
  final String status;

  RouteUpdateBody(this.routeId, this.status);

  factory RouteUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$RouteUpdateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RouteUpdateBodyToJson(this);
}
