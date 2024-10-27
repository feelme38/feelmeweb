import 'package:json_annotation/json_annotation.dart';
part 'region_response.g.dart';

@JsonSerializable()
class RegionResponse {
  final String id;
  final String name;

  RegionResponse(
      this.id,
      this.name
  );

  factory RegionResponse.fromJson(Map<String, dynamic> json) => _$RegionResponseFromJson(json);
}