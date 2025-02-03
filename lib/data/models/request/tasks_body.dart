import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tasks_body.g.dart';

@JsonSerializable()
class TasksBody {
  final String name;
  final DateTime visitTime;
  final String typeId;
  final String clientId;
  final String addressId;
  final List<SubtaskBody> subtasks;

  TasksBody(this.name, this.visitTime, this.typeId, this.clientId,
      this.addressId, this.subtasks);

  factory TasksBody.fromJson(Map<String, dynamic> json) =>
      _$TasksBodyFromJson(json);
  Map<String, dynamic> toJson() => _$TasksBodyToJson(this);
}
