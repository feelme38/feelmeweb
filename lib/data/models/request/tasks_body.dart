import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks_body.g.dart';

@JsonSerializable()
class TasksBody {
  final String? id;
  final String name;
  final String clientId;
  final String addressId;
  final DateTime? visitDateTime;
  final List<SubtaskBody> subtasks;

  TasksBody({
    required this.name,
    required this.clientId,
    required this.addressId,
    required this.subtasks,
    required this.visitDateTime,
    this.id, // Оставляем id как необязательный именованный параметр
  });

  factory TasksBody.fromJson(Map<String, dynamic> json) =>
      _$TasksBodyFromJson(json);
  Map<String, dynamic> toJson() => _$TasksBodyToJson(this);

  /// Метод copyWith для удобного создания изменённых копий объекта
  TasksBody copyWith({
    String? id,
    String? name,
    Object? visitDateTime = _unset, // <= отличие!
    String? typeId,
    String? clientId,
    String? addressId,
    List<SubtaskBody>? subtasks,
  }) {
    return TasksBody(
      name: name ?? this.name,
      clientId: clientId ?? this.clientId,
      addressId: addressId ?? this.addressId,
      subtasks: subtasks ?? this.subtasks,
      id: id ?? this.id, // Исправленный порядок
      visitDateTime: visitDateTime == _unset
          ? this.visitDateTime
          : visitDateTime as DateTime?,
    );
  }
}

// Вне класса (глобально в файле)
const _unset = Object();
