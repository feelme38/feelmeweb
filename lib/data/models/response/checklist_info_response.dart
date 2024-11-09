import 'package:feelmeweb/data/models/response/local_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_info_response.g.dart';

@JsonSerializable()
class CheckListInfoResponse {
  final String? id;
  final LocalDate? createdAt;
  final ChecklistAroma checklistAroma;
  final DeviceWorkSchedule? deviceWorkSchedule;
  final String? deviceId;
  final String? deviceModel;
  final String? contract;
  final String? deviceLocation;

  CheckListInfoResponse({
    this.id,
    required this.createdAt,
    required this.checklistAroma,
    this.deviceLocation,
    this.deviceWorkSchedule,
    this.deviceId,
    this.deviceModel,
    this.contract,
  });

  factory CheckListInfoResponse.fromJson(Map<String, dynamic> json) => _$CheckListInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckListInfoResponseToJson(this);
}

@JsonSerializable()
class ChecklistAroma {
  final String? newAromaId;
  final double volumeMl;
  final String? newAromaName;

  ChecklistAroma(this.newAromaId, this.newAromaName, {required this.volumeMl});

  factory ChecklistAroma.fromJson(Map<String, dynamic> json) => _$ChecklistAromaFromJson(json);
  Map<String, dynamic> toJson() => _$ChecklistAromaToJson(this);
}

@JsonSerializable()
class DeviceWorkSchedule {
  final String type;
  final int? duration;
  final List<WorkMode>? workModes;

  DeviceWorkSchedule(this.duration, {required this.type, this.workModes});

  factory DeviceWorkSchedule.fromJson(Map<String, dynamic> json) => _$DeviceWorkScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceWorkScheduleToJson(this);
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

  factory WorkMode.fromJson(Map<String, dynamic> json) => _$WorkModeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkModeToJson(this);
}

@JsonEnum()
enum WeekDay {
  MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}