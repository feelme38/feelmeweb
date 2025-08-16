import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_response.freezed.dart';
part 'route_response.g.dart';

@freezed
class RouteResponse with _$RouteResponse {
  const factory RouteResponse({
    required String id,
    required List<Task> tasks,
    UserResponse? engineer,
    CustomerResponse? client,
    required String routeStatus,
    required int allTasksCount,
    required int completedTasksCount,
    required DateTime routeDate, // LocalDate (date only)
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
}

@JsonSerializable()
class Task {
  final String id;
  final String name;
  final Client client;
  final String taskStatus;
  final int completedTime;
  final Address address;
  final List<Subtask> subtasks;
  final String routeId;
  final List<LastCheckListInfoResponse> checkListInfo;
  final DateTime? visitTimeFrom;
  final DateTime? visitTimeTo;
  final String? comment;

  Task(
      {required this.id,
      required this.name,
      required this.client,
      required this.taskStatus,
      required this.completedTime,
      required this.address,
      required this.subtasks,
      required this.routeId,
      required this.checkListInfo,
      this.visitTimeFrom,
      this.visitTimeTo,
      this.comment});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith(
      {String? id,
      String? name,
      TaskType? taskType,
      Client? client,
      String? taskStatus,
      int? completedTime,
      Address? address,
      List<Subtask>? subtasks,
      String? routeId,
      List<LastCheckListInfoResponse>? checkListInfo,
      DateTime? visitTimeFrom,
      DateTime? visitTimeTo,
      String? comment}) {
    return Task(
        id: id ?? this.id,
        name: name ?? this.name,
        client: client ?? this.client,
        taskStatus: taskStatus ?? this.taskStatus,
        completedTime: completedTime ?? this.completedTime,
        address: address ?? this.address,
        subtasks: subtasks ?? this.subtasks,
        routeId: routeId ?? this.routeId,
        checkListInfo: checkListInfo ?? this.checkListInfo,
        visitTimeFrom: visitTimeFrom ?? this.visitTimeFrom,
        visitTimeTo: visitTimeTo ?? this.visitTimeTo,
        comment: comment ?? this.comment);
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
  final String? volumeFormula;
  final String? contractType;
  final bool isNeedChangeBattery;
  final String subtaskStatus;
  final String? startAt;
  final String? endAt;
  final String? arrivalTime;
  final CheckListInfoResponse? checklist;
  final SubtaskTypeResponse subtaskType;

  Subtask({
    required this.id,
    required this.taskId,
    required this.device,
    required this.comment,
    required this.expectedAroma,
    required this.expectedAromaVolume,
    this.volumeFormula,
    this.contractType,
    required this.isNeedChangeBattery,
    required this.subtaskStatus,
    this.startAt,
    this.endAt,
    this.arrivalTime,
    this.checklist,
    required this.subtaskType,
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
    String? volumeFormula,
    String? contractType,
    bool? isNeedChangeBattery,
    String? subtaskStatus,
    String? startAt,
    String? endAt,
    String? arrivalTime,
    SubtaskTypeResponse? subtaskType,
  }) {
    return Subtask(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      device: device ?? this.device,
      comment: comment ?? this.comment,
      expectedAroma: expectedAroma ?? this.expectedAroma,
      expectedAromaVolume: expectedAromaVolume ?? this.expectedAromaVolume,
      volumeFormula: volumeFormula ?? this.volumeFormula,
      contractType: contractType ?? this.contractType,
      isNeedChangeBattery: isNeedChangeBattery ?? this.isNeedChangeBattery,
      subtaskStatus: subtaskStatus ?? this.subtaskStatus,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      subtaskType: subtaskType ?? this.subtaskType,
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
  final String? powerType;
  final String? model;
  final double? aromaVolume;
  final String? contract;
  final String? place;
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
