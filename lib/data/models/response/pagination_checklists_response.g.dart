// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_checklists_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationChecklistsResponse _$PaginationChecklistsResponseFromJson(
        Map<String, dynamic> json) =>
    PaginationChecklistsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ChecklistResponseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationChecklistsResponseToJson(
        PaginationChecklistsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

ChecklistResponseItem _$ChecklistResponseItemFromJson(
        Map<String, dynamic> json) =>
    ChecklistResponseItem(
      id: json['id'] as String,
      subtask: json['subtask'] == null
          ? null
          : Subtask.fromJson(json['subtask'] as Map<String, dynamic>),
      authorId: json['authorId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdAtDate: json['createdAtDate'] as String,
      subtaskId: json['subtaskId'] as String?,
      aromaFeel: json['aromaFeel'] as String,
      aromaAction: $enumDecode(_$AromaActionEnumMap, json['aromaAction']),
      actionCause: $enumDecode(_$ActionCauseEnumMap, json['actionCause']),
      newAroma: Aroma.fromJson(json['newAroma'] as Map<String, dynamic>),
      aromaVolume: (json['aromaVolume'] as num).toDouble(),
      powerType: PowerType.fromJson(json['powerType'] as Map<String, dynamic>),
      powerPayment: json['powerPayment'] as String,
      durationWorkMode: json['durationWorkMode'] as int,
      comment: json['comment'] as String,
      pdfUrl: json['pdfUrl'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      engineer: UserResponse.fromJson(json['engineer'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      workSchedule: DeviceWorkSchedule.fromJson(
          json['workSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChecklistResponseItemToJson(
        ChecklistResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subtask': instance.subtask,
      'authorId': instance.authorId,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdAtDate': instance.createdAtDate,
      'subtaskId': instance.subtaskId,
      'aromaFeel': instance.aromaFeel,
      'aromaAction': _$AromaActionEnumMap[instance.aromaAction]!,
      'actionCause': _$ActionCauseEnumMap[instance.actionCause]!,
      'newAroma': instance.newAroma,
      'aromaVolume': instance.aromaVolume,
      'powerType': instance.powerType,
      'powerPayment': instance.powerPayment,
      'durationWorkMode': instance.durationWorkMode,
      'comment': instance.comment,
      'pdfUrl': instance.pdfUrl,
      'address': instance.address,
      'engineer': instance.engineer,
      'attachments': instance.attachments,
      'workSchedule': instance.workSchedule,
    };

const _$AromaActionEnumMap = {
  AromaAction.REFILLED: 'REFILLED',
  AromaAction.CHANGED: 'CHANGED',
};

const _$ActionCauseEnumMap = {
  ActionCause.LEASE: 'LEASE',
  ActionCause.BOUGHT_PAID: 'BOUGHT_PAID',
  ActionCause.BOUGHT_INVOICE: 'BOUGHT_INVOICE',
  ActionCause.BOUGHT_CARD: 'BOUGHT_CARD',
  ActionCause.BOUGHT_CASH: 'BOUGHT_CASH',
  ActionCause.STORES_IN_OFFICE: 'STORES_IN_OFFICE',
  ActionCause.STORES_ITSELF: 'STORES_ITSELF',
};

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

PowerType _$PowerTypeFromJson(Map<String, dynamic> json) => PowerType(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PowerTypeToJson(PowerType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
