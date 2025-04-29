import 'package:json_annotation/json_annotation.dart';

part 'update_region_body.g.dart';

@JsonSerializable()
class UpdateRegionBody {
  final String regionId;
  final String name;

  UpdateRegionBody({
    required this.regionId,
    required this.name,
  });

  factory UpdateRegionBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateRegionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRegionBodyToJson(this);
}
