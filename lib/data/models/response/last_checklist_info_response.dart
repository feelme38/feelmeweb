import 'package:feelmeweb/data/models/response/local_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_checklist_info_response.g.dart';

@JsonSerializable()
class LastCheckListInfoResponse {
  final String? id;
  final LocalDate? createdAt;
  final ChecklistAroma checklistAroma;
  final DeviceWorkSchedule? deviceWorkSchedule;
  final String? deviceId;
  final String? deviceModel;
  final String? contract;
  final String? deviceLocation;
  final String? customerId;
  final String? addressId;

  LastCheckListInfoResponse({
    this.id,
    required this.createdAt,
    required this.checklistAroma,
    this.deviceLocation,
    this.deviceWorkSchedule,
    this.deviceId,
    this.deviceModel,
    this.contract,
    this.customerId,
    this.addressId,
  });

  factory LastCheckListInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$LastCheckListInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LastCheckListInfoResponseToJson(this);

  LastCheckListInfoResponse copyWith({
    String? id,
    LocalDate? createdAt,
    ChecklistAroma? checklistAroma,
    DeviceWorkSchedule? deviceWorkSchedule,
    String? deviceId,
    String? deviceModel,
    String? contract,
    String? deviceLocation,
    String? customerId,
    String? addressId,
  }) {
    return LastCheckListInfoResponse(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      checklistAroma: checklistAroma ?? this.checklistAroma,
      deviceWorkSchedule: deviceWorkSchedule ?? this.deviceWorkSchedule,
      deviceId: deviceId ?? this.deviceId,
      deviceModel: deviceModel ?? this.deviceModel,
      contract: contract ?? this.contract,
      deviceLocation: deviceLocation ?? this.deviceLocation,
      customerId: customerId ?? this.customerId,
      addressId: addressId ?? this.addressId,
    );
  }
}

@JsonSerializable()
class ChecklistAroma {
  final String? newAromaId;
  final double volumeMl;
  final String? newAromaName;

  ChecklistAroma(this.newAromaId, this.newAromaName, {required this.volumeMl});

  factory ChecklistAroma.fromJson(Map<String, dynamic> json) =>
      _$ChecklistAromaFromJson(json);
  Map<String, dynamic> toJson() => _$ChecklistAromaToJson(this);

  ChecklistAroma copyWith({
    String? newAromaId,
    double? volumeMl,
    String? newAromaName,
  }) {
    return ChecklistAroma(
      newAromaId ?? this.newAromaId,
      newAromaName ?? this.newAromaName,
      volumeMl: volumeMl ?? this.volumeMl,
    );
  }
}

@JsonSerializable()
class DeviceWorkSchedule {
  final String type;
  final int? duration;
  final List<WorkMode>? workModes;

  DeviceWorkSchedule(this.duration, {required this.type, this.workModes});

  factory DeviceWorkSchedule.fromJson(Map<String, dynamic> json) =>
      _$DeviceWorkScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceWorkScheduleToJson(this);

  DeviceWorkSchedule copyWith({
    String? type,
    int? duration,
    List<WorkMode>? workModes,
  }) {
    return DeviceWorkSchedule(
      duration ?? this.duration,
      type: type ?? this.type,
      workModes: workModes ?? this.workModes,
    );
  }
}

@JsonSerializable()
class WorkMode {
  final int tWork;
  final int tPause;
  final int tStart;
  final int tEnd;
  final List<WeekDay> workDays;

  WorkMode({
    required this.tWork,
    required this.tPause,
    required this.tStart,
    required this.tEnd,
    required this.workDays,
  });

  factory WorkMode.fromJson(Map<String, dynamic> json) =>
      _$WorkModeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkModeToJson(this);

  WorkMode copyWith({
    int? tWork,
    int? tPause,
    int? tStart,
    int? tEnd,
    List<WeekDay>? workDays,
  }) {
    return WorkMode(
      tWork: tWork ?? this.tWork,
      tPause: tPause ?? this.tPause,
      tStart: tStart ?? this.tStart,
      tEnd: tEnd ?? this.tEnd,
      workDays: workDays ?? this.workDays,
    );
  }
}

@JsonEnum()
enum WeekDay { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }
