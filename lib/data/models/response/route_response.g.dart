// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      name: json['name'] as String,
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      taskStatus: json['taskStatus'] as String,
      completedTime: json['completedTime'] as int,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      subtasks: (json['subtasks'] as List<dynamic>)
          .map((e) => Subtask.fromJson(e as Map<String, dynamic>))
          .toList(),
      routeId: json['routeId'] as String,
      checkListInfo: (json['checkListInfo'] as List<dynamic>)
          .map((e) =>
              LastCheckListInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      visitTimeFrom: json['visitTimeFrom'] == null
          ? null
          : DateTime.parse(json['visitTimeFrom'] as String),
      visitTimeTo: json['visitTimeTo'] == null
          ? null
          : DateTime.parse(json['visitTimeTo'] as String),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'client': instance.client,
      'taskStatus': instance.taskStatus,
      'completedTime': instance.completedTime,
      'address': instance.address,
      'subtasks': instance.subtasks,
      'routeId': instance.routeId,
      'checkListInfo': instance.checkListInfo,
      'visitTimeFrom': instance.visitTimeFrom?.toIso8601String(),
      'visitTimeTo': instance.visitTimeTo?.toIso8601String(),
      'comment': instance.comment,
    };

Subtask _$SubtaskFromJson(Map<String, dynamic> json) => Subtask(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      device: Device.fromJson(json['device'] as Map<String, dynamic>),
      comment: json['comment'] as String,
      expectedAroma:
          Aroma.fromJson(json['expectedAroma'] as Map<String, dynamic>),
      expectedAromaVolume: (json['expectedAromaVolume'] as num).toDouble(),
      volumeFormula: json['volumeFormula'] as String?,
      contractType: json['contractType'] as String?,
      isNeedChangeBattery: json['isNeedChangeBattery'] as bool,
      subtaskStatus: json['subtaskStatus'] as String,
      startAt: json['startAt'] as String?,
      endAt: json['endAt'] as String?,
      arrivalTime: json['arrivalTime'] as String?,
      checklist: json['checklist'] == null
          ? null
          : CheckListInfoResponse.fromJson(
              json['checklist'] as Map<String, dynamic>),
      subtaskType: SubtaskTypeResponse.fromJson(
          json['subtaskType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubtaskToJson(Subtask instance) => <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'device': instance.device,
      'comment': instance.comment,
      'expectedAroma': instance.expectedAroma,
      'expectedAromaVolume': instance.expectedAromaVolume,
      'volumeFormula': instance.volumeFormula,
      'contractType': instance.contractType,
      'isNeedChangeBattery': instance.isNeedChangeBattery,
      'subtaskStatus': instance.subtaskStatus,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'arrivalTime': instance.arrivalTime,
      'checklist': instance.checklist,
      'subtaskType': instance.subtaskType,
    };

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) => TaskType(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TaskTypeToJson(TaskType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      ownerName: json['ownerName'] as String,
      devices:
          (json['devices'] as List<dynamic>).map((e) => e as String).toList(),
      addresses:
          (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'ownerName': instance.ownerName,
      'devices': instance.devices,
      'addresses': instance.addresses,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String,
      powerType: json['powerType'] as String?,
      model: json['model'] as String?,
      aromaVolume: (json['aromaVolume'] as num?)?.toDouble(),
      contract: json['contract'] as String?,
      place: json['place'] as String?,
      aroma: json['aroma'] == null
          ? null
          : Aroma.fromJson(json['aroma'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'powerType': instance.powerType,
      'model': instance.model,
      'aromaVolume': instance.aromaVolume,
      'contract': instance.contract,
      'place': instance.place,
      'aroma': instance.aroma,
    };

Aroma _$AromaFromJson(Map<String, dynamic> json) => Aroma(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AromaToJson(Aroma instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$RouteResponseImpl _$$RouteResponseImplFromJson(Map<String, dynamic> json) =>
    _$RouteResponseImpl(
      id: json['id'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      engineer: json['engineer'] == null
          ? null
          : UserResponse.fromJson(json['engineer'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : CustomerResponse.fromJson(json['client'] as Map<String, dynamic>),
      routeStatus: json['routeStatus'] as String,
      allTasksCount: json['allTasksCount'] as int,
      completedTasksCount: json['completedTasksCount'] as int,
      routeDate: DateTime.parse(json['routeDate'] as String),
    );

Map<String, dynamic> _$$RouteResponseImplToJson(_$RouteResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tasks': instance.tasks,
      'engineer': instance.engineer,
      'client': instance.client,
      'routeStatus': instance.routeStatus,
      'allTasksCount': instance.allTasksCount,
      'completedTasksCount': instance.completedTasksCount,
      'routeDate': instance.routeDate.toIso8601String(),
    };
