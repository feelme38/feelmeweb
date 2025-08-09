import 'package:json_annotation/json_annotation.dart';

part 'aroma_response.g.dart';

@JsonSerializable()
class AromaResponse {
  final String id;
  final String name;
  final AromaType? type;

  AromaResponse({
    required this.id,
    required this.name,
    this.type,
  });

  factory AromaResponse.fromJson(Map<String, dynamic> json) =>
      _$AromaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AromaResponseToJson(this);
}

@JsonEnum()
enum AromaType { CLASSIC, PREMIUM, LUXE }
