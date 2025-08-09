import 'package:json_annotation/json_annotation.dart';

part 'subtask_types_response.g.dart';

@JsonSerializable()
class SubtaskTypeResponse {
  final String id;
  final String name;

  SubtaskTypeResponse(this.id, this.name);

  factory SubtaskTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$SubtaskTypeResponseFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskTypeResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
