import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_response.g.dart';

@JsonSerializable()
class RouteResponse {
  final String id;
  final List<Task> tasks;
  final String routeStatus;
  final int allTasksCount;
  final int completedTasksCount;

  RouteResponse({
    required this.id,
    required this.tasks,
    required this.routeStatus,
    required this.allTasksCount,
    required this.completedTasksCount,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RouteResponseToJson(this);

  RouteResponse copyWith({
    String? id,
    List<Task>? tasks,
    String? routeStatus,
    int? allTasksCount,
    int? completedTasksCount,
  }) {
    return RouteResponse(
      id: id ?? this.id,
      tasks: tasks ?? this.tasks,
      routeStatus: routeStatus ?? this.routeStatus,
      allTasksCount: allTasksCount ?? this.allTasksCount,
      completedTasksCount: completedTasksCount ?? this.completedTasksCount,
    );
  }
}

@JsonSerializable()
class Task {
  final String id;
  final String name;
  final TaskType taskType;
  final Client client;
  final String taskStatus;
  final int completedTime;
  final Address address;
  final List<Subtask> subtasks;
  final String routeId;
  final List<LastCheckListInfoResponse> checkListInfo;

  Task({
    required this.id,
    required this.name,
    required this.taskType,
    required this.client,
    required this.taskStatus,
    required this.completedTime,
    required this.address,
    required this.subtasks,
    required this.routeId,
    required this.checkListInfo,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? name,
    TaskType? taskType,
    Client? client,
    String? taskStatus,
    int? completedTime,
    Address? address,
    List<Subtask>? subtasks,
    String? routeId,
    List<LastCheckListInfoResponse>? checkListInfo,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      taskType: taskType ?? this.taskType,
      client: client ?? this.client,
      taskStatus: taskStatus ?? this.taskStatus,
      completedTime: completedTime ?? this.completedTime,
      address: address ?? this.address,
      subtasks: subtasks ?? this.subtasks,
      routeId: routeId ?? this.routeId,
      checkListInfo: checkListInfo ?? this.checkListInfo,
    );
  }
}

@JsonSerializable()
class Subtask {
  final String id;
  final String taskId;
  final Device device;
  final String comment;
  final Aroma expectedAroma;
  final double expectedAromaVolume;
  final bool isNeedChangeBattery;
  final String subtaskStatus;
  final int estimatedCompletedTime;
  final String? startAt;
  final String? endAt;
  final String? arrivalTime;
  final CheckListInfoResponse? checklist;

  Subtask({
    required this.id,
    required this.taskId,
    required this.device,
    required this.comment,
    required this.expectedAroma,
    required this.expectedAromaVolume,
    required this.isNeedChangeBattery,
    required this.subtaskStatus,
    required this.estimatedCompletedTime,
    this.startAt,
    this.endAt,
    this.arrivalTime,
    this.checklist,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) =>
      _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);

  Subtask copyWith({
    String? id,
    String? taskId,
    Device? device,
    String? comment,
    Aroma? expectedAroma,
    double? expectedAromaVolume,
    bool? isNeedChangeBattery,
    String? subtaskStatus,
    int? estimatedCompletedTime,
    String? startAt,
    String? endAt,
    String? arrivalTime,
  }) {
    return Subtask(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      device: device ?? this.device,
      comment: comment ?? this.comment,
      expectedAroma: expectedAroma ?? this.expectedAroma,
      expectedAromaVolume: expectedAromaVolume ?? this.expectedAromaVolume,
      isNeedChangeBattery: isNeedChangeBattery ?? this.isNeedChangeBattery,
      subtaskStatus: subtaskStatus ?? this.subtaskStatus,
      estimatedCompletedTime:
          estimatedCompletedTime ?? this.estimatedCompletedTime,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }
}

@JsonSerializable()
class TaskType {
  final String id;
  final String name;

  TaskType({required this.id, required this.name});

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);
  Map<String, dynamic> toJson() => _$TaskTypeToJson(this);
}

@JsonSerializable()
class Client {
  final String id;
  final String name;
  final String phone;
  final String ownerName;
  final List<String> devices;
  final List<String> addresses;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.ownerName,
    required this.devices,
    required this.addresses,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class Address {
  final String id;
  final String customerId;
  final String address;
  final double lat;
  final double lng;

  Address({
    required this.id,
    required this.customerId,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Device {
  final String id;
  final String powerType;
  final String model;
  final double aromaVolume;
  final String contract;
  final String place;
  final Aroma? aroma;

  Device({
    required this.id,
    required this.powerType,
    required this.model,
    required this.aromaVolume,
    required this.contract,
    required this.place,
    this.aroma,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable()
class Aroma {
  final String id;
  final String name;

  Aroma({required this.id, required this.name});

  factory Aroma.fromJson(Map<String, dynamic> json) => _$AromaFromJson(json);
  Map<String, dynamic> toJson() => _$AromaToJson(this);
}
