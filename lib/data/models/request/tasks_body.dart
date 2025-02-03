import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks_body.g.dart';

@JsonSerializable()
class TasksBody {
  final String? id;
  final String name;
  final DateTime visitTime;
  final String typeId;
  final String clientId;
  final String addressId;
  final List<SubtaskBody> subtasks;

  TasksBody(
    this.name,
    this.visitTime,
    this.typeId,
    this.clientId,
    this.addressId,
    this.subtasks, {
    this.id, // Оставляем id как необязательный именованный параметр
  });

  factory TasksBody.fromJson(Map<String, dynamic> json) =>
      _$TasksBodyFromJson(json);
  Map<String, dynamic> toJson() => _$TasksBodyToJson(this);

  /// Метод copyWith для удобного создания изменённых копий объекта
  TasksBody copyWith({
    String? id,
    String? name,
    DateTime? visitTime,
    String? typeId,
    String? clientId,
    String? addressId,
    List<SubtaskBody>? subtasks,
  }) {
    return TasksBody(
      name ?? this.name,
      visitTime ?? this.visitTime,
      typeId ?? this.typeId,
      clientId ?? this.clientId,
      addressId ?? this.addressId,
      subtasks ?? this.subtasks,
      id: id ?? this.id, // Исправленный порядок
    );
  }
}
