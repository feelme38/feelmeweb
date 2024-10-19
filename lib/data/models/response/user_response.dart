import 'package:base_class_gen/copy_empty_annotations/copy_empty_annotations.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String id;
  final String name;
  final String? profileUrl;
  final int? allTasksCount;
  final int? completedTasksCount;
  final RouteStatus? routeStatus;
  final String? routeId;
  final String? activeTaskId;

  UserResponse(
      this.id,
      this.name,
      this.profileUrl,
      this.allTasksCount,
      this.completedTasksCount,
      this.routeStatus,
      this.routeId,
      this.activeTaskId
  );

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
}

@JsonEnum()
enum RouteStatus {
  ASSIGNED, STARTED, PAUSED, FINISHED
}