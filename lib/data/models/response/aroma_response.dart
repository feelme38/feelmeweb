import 'package:json_annotation/json_annotation.dart';
part 'aroma_response.g.dart';

@JsonSerializable()
class AromaResponse {
  final String id;
  final String name;

  AromaResponse(
      this.id,
      this.name
  );

  factory AromaResponse.fromJson(Map<String, dynamic> json) => _$AromaResponseFromJson(json);
}