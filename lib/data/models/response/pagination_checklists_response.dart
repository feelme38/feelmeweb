import 'package:collection/collection.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/pagination_routes_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_checklists_response.g.dart';

@JsonSerializable()
class PaginationChecklistsResponse {
  final List<ChecklistResponseItem>? data;
  final Meta? meta;

  PaginationChecklistsResponse({
    this.data,
    this.meta,
  });

  factory PaginationChecklistsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationChecklistsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationChecklistsResponseToJson(this);
}

@JsonSerializable()
class ChecklistResponseItem {
  final String id;
  final Subtask? subtask;
  final String authorId;
  final DateTime createdAt;
  final String createdAtDate;
  final String? subtaskId;
  final String aromaFeel;
  final AromaAction aromaAction;
  final ActionCause actionCause;
  final Aroma newAroma;
  final double aromaVolume;
  final PowerType powerType;
  final PowerPayment powerPayment;
  final bool? isNeedChangeBattery;

  final String comment;
  final String pdfUrl;
  final Address address;
  final UserResponse engineer;
  final List<Attachment> attachments;
  final DeviceWorkSchedule workSchedule;

  ChecklistResponseItem({
    required this.id,
    this.subtask,
    required this.authorId,
    required this.createdAt,
    required this.createdAtDate,
    this.subtaskId,
    required this.aromaFeel,
    required this.aromaAction,
    required this.actionCause,
    required this.newAroma,
    required this.aromaVolume,
    required this.powerType,
    required this.powerPayment,
    required this.comment,
    required this.pdfUrl,
    required this.address,
    required this.engineer,
    required this.attachments,
    required this.workSchedule,
    this.isNeedChangeBattery,
  });

  factory ChecklistResponseItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistResponseItemFromJson(json);
  Map<String, dynamic> toJson() => _$ChecklistResponseItemToJson(this);
}

@JsonSerializable()
class Attachment {
  final String name;
  final String url;

  Attachment({required this.name, required this.url});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable()
class PowerType {
  final String id;
  final String name;

  PowerType({required this.id, required this.name});

  factory PowerType.fromJson(Map<String, dynamic> json) =>
      _$PowerTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PowerTypeToJson(this);
}

@JsonEnum()
enum ActionCause {
  LEASE,
  BOUGHT_PAID,
  BOUGHT_INVOICE,
  BOUGHT_CARD,
  BOUGHT_CASH,
  STORES_IN_OFFICE,
  STORES_ITSELF
}

extension ActionCauseExtension on ActionCause {
  String get displayName {
    switch (this) {
      case ActionCause.LEASE:
        return "Аренда";
      case ActionCause.BOUGHT_PAID:
        return "Купил (оплачено)";
      case ActionCause.BOUGHT_INVOICE:
        return "Купил (выставить счет)";
      case ActionCause.BOUGHT_CARD:
        return "Купил (переведут на карту)";
      case ActionCause.BOUGHT_CASH:
        return "Купил (рассчитались наличкой)";
      case ActionCause.STORES_IN_OFFICE:
        return "Хранит в офисе";
      case ActionCause.STORES_ITSELF:
        return "Хранит у себя";
    }
  }

  static ActionCause? fromString(String? str) {
    return ActionCause.values.firstWhereOrNull((e) => e.name == str);
  }
}

@JsonEnum()
enum AromaAction { REFILLED, CHANGED }

extension AromaActionExtension on AromaAction {
  String get displayName {
    switch (this) {
      case AromaAction.REFILLED:
        return "Долил";
      case AromaAction.CHANGED:
        return "Заменил";
    }
  }

  static AromaAction? fromString(String str) {
    return AromaAction.values.firstWhereOrNull((e) => e.name == str);
  }
}

@JsonEnum()
enum AromaFeel { TOO_MUCH, WOW, WANT_MORE, WEAK_SMELL, DOESNT_SMELL, OFF }

extension AromaFeelExtension on AromaFeel {
  String get displayName {
    switch (this) {
      case AromaFeel.TOO_MUCH:
        return "Перебор";
      case AromaFeel.WOW:
        return "ВАУ";
      case AromaFeel.WANT_MORE:
        return "Хотелось побольше";
      case AromaFeel.WEAK_SMELL:
        return "Слабо чувствуется";
      case AromaFeel.DOESNT_SMELL:
        return "Не пахнет";
      case AromaFeel.OFF:
        return "Выключено";
    }
  }

  static AromaFeel? fromString(String str) {
    return AromaFeel.values.firstWhereOrNull((e) => e.name == str);
  }
}

@JsonEnum()
enum PowerPayment {
  ISSUE_INVOICE,
  PAYMENT_TO_CARD,
  CASH_TO_ENGINEER,
  EP_IN_STORAGE,
  LEASE
}

extension PowerPaymentExtension on PowerPayment {
  String get displayName {
    switch (this) {
      case PowerPayment.ISSUE_INVOICE:
        return "Выставить счет";
      case PowerPayment.PAYMENT_TO_CARD:
        return "Получить оплату на карту";
      case PowerPayment.CASH_TO_ENGINEER:
        return "Отлали наличкой СИ";
      case PowerPayment.EP_IN_STORAGE:
        return "ЭП на хранении";
      case PowerPayment.LEASE:
        return "Аренда";
    }
  }

  static PowerPayment? fromString(String str) {
    return PowerPayment.values.firstWhereOrNull((e) => e.name == str);
  }
}
