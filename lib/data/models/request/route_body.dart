import 'package:feelmeweb/data/models/request/tasks_body.dart';
import 'package:json_annotation/json_annotation.dart';
part 'route_body.g.dart';

@JsonSerializable()
class RouteBody {

  final String userId;
  final List<TasksBody> tasks;

  RouteBody(
      this.userId,
      this.tasks
      );

  factory RouteBody.fromJson(Map<String, dynamic> json) => _$RouteBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RouteBodyToJson(this);
}