import 'package:json_annotation/json_annotation.dart';
part 'today_routes_response.g.dart';
@JsonSerializable()
class TodayRouteResponse {
  final String? id;

  final String? routeStatus;
  final int? allTasksCount;
  final int? completedTasksCount;
  final List<TodayRouteTask>? tasks;
  final TodayRouteEngineer? engineer;

  TodayRouteResponse(
      {this.id,
      this.routeStatus,
      this.allTasksCount,
      this.completedTasksCount,
      this.tasks,
      this.engineer});

  factory TodayRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteResponseFromJson(json);
}

@JsonSerializable()
class TodayRouteEngineer {
  final String? id;
  final String? name;
  final TodayRouteEngineerSettings? settings;
  final double? lastLat;
  final double? lastLon;

  TodayRouteEngineer(
      {this.lastLat, this.lastLon, this.id, this.name, this.settings});

  factory TodayRouteEngineer.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteEngineerFromJson(json);
}

@JsonSerializable()
class TodayRouteEngineerSettings {
  final String? wikiUrl;

  TodayRouteEngineerSettings({this.wikiUrl});

  factory TodayRouteEngineerSettings.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteEngineerSettingsFromJson(json);
}

@JsonSerializable()
class TodayRouteTask {
  final String? id;
  final String? name;
  final TodayRouteTaskType? taskType;
  final TodayRouteClient? client;
  final String? taskStatus;
  final int? completedTime;
  final TodayRouteAddress? address;
  final List<dynamic>? subtasks;

  TodayRouteTask(
      {this.id,
      this.name,
      this.taskType,
      this.client,
      this.taskStatus,
      this.completedTime,
      this.address,
      this.subtasks});

  factory TodayRouteTask.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteTaskFromJson(json);
}

@JsonSerializable()
class TodayRouteTaskType {
  final String? id;
  final String? name;

  TodayRouteTaskType({this.id, this.name});

  factory TodayRouteTaskType.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteTaskTypeFromJson(json);
}

@JsonSerializable()
class TodayRouteClient {
  final String? id;
  final String? name;
  final String? phone;
  final String? ownerName;
  final List<dynamic>? devices;
  final List<dynamic>? addresses;

  TodayRouteClient(
      {this.id,
      this.name,
      this.phone,
      this.ownerName,
      this.devices,
      this.addresses});

  factory TodayRouteClient.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteClientFromJson(json);
}
@JsonSerializable()
class TodayRouteAddress {
  final String? id;
  final String? customerId;
  final String? address;
  final double? lat;
  final double? lng;

  TodayRouteAddress(
      {this.id, this.customerId, this.address, this.lat, this.lng});

  factory TodayRouteAddress.fromJson(Map<String, dynamic> json) =>
      _$TodayRouteAddressFromJson(json);
}
