import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks_body.g.dart';

@JsonSerializable()
class TasksBody {
  final String? id;
  final String name;
  final String clientId;
  final String addressId;
  final String? taskStatus;
  final DateTime? visitTimeFrom;
  final DateTime? visitTimeTo;
  final String? comment;
  final List<SubtaskBody> subtasks;

  TasksBody({
    required this.name,
    required this.clientId,
    required this.addressId,
    this.taskStatus,
    required this.subtasks,
    this.visitTimeFrom,
    this.visitTimeTo,
    this.comment,
    this.id, // Оставляем id как необязательный именованный параметр
  });

  factory TasksBody.fromJson(Map<String, dynamic> json) =>
      _$TasksBodyFromJson(json);
  Map<String, dynamic> toJson() => _$TasksBodyToJson(this);

  /// Метод copyWith для удобного создания изменённых копий объекта
  TasksBody copyWith({
    String? id,
    String? name,
    
    Object? visitTimeFrom = _unset,
    Object? visitTimeTo = _unset,
    String? comment,
    String? typeId,
    String? clientId,
    String? addressId,
    String? taskStatus,
    List<SubtaskBody>? subtasks,
  }) {
    return TasksBody(
      name: name ?? this.name,
      clientId: clientId ?? this.clientId,
      addressId: addressId ?? this.addressId,
      taskStatus: taskStatus ?? this.taskStatus,
      subtasks: subtasks ?? this.subtasks,
      id: id ?? this.id, // Исправленный порядок
      
      visitTimeFrom:
          visitTimeFrom == _unset ? this.visitTimeFrom : visitTimeFrom as DateTime?,
      visitTimeTo:
          visitTimeTo == _unset ? this.visitTimeTo : visitTimeTo as DateTime?,
      comment: comment ?? this.comment,
    );
  }
}

// Вне класса (глобально в файле)
const _unset = Object();
