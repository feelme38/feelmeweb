import 'package:json_annotation/json_annotation.dart';

part 'task_types_response.g.dart';

@JsonSerializable()
class TaskTypeResponse {
  final String id;
  final String name;

  TaskTypeResponse(this.id, this.name);

  factory TaskTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeResponseFromJson(json);
}
