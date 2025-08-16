import 'package:json_annotation/json_annotation.dart';

part 'subtask_body.g.dart';

@JsonSerializable()
class SubtaskBody {
  final String? id;
  final String? customerId;
  final String? addressId;
  final String? subtaskStatus;
  final String deviceId;
  final String comment;
  final String expectedAromaId;
  final double expectedAromaVolume;
  final String volumeFormula;
  final String contractType;
  final String typeId;

  SubtaskBody(
    this.customerId,
    this.deviceId,
    this.comment,
    this.expectedAromaId,
    this.expectedAromaVolume,
    this.volumeFormula,
    this.contractType,
    this.typeId, {
    this.id,
    this.addressId,
    this.subtaskStatus,
  });

  factory SubtaskBody.fromJson(Map<String, dynamic> json) =>
      _$SubtaskBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SubtaskBodyToJson(this);

  /// Метод copyWith для создания изменённых копий объекта
  SubtaskBody copyWith({
    String? id,
    String? customerId,
    String? addressId,
    String? subtaskStatus,
    String? deviceId,
    String? comment,
    String? expectedAromaId,
    double? expectedAromaVolume,
    String? volumeFormula,
    String? contractType,
    String? typeId,
  }) {
    return SubtaskBody(
        customerId ?? this.customerId,
        deviceId ?? this.deviceId,
        comment ?? this.comment,
        expectedAromaId ?? this.expectedAromaId,
        expectedAromaVolume ?? this.expectedAromaVolume,
        volumeFormula ?? this.volumeFormula,
        contractType ?? this.contractType,
        typeId ?? this.typeId,
        id: id ?? this.id,
        addressId: addressId ?? this.addressId,
        subtaskStatus: subtaskStatus ?? this.subtaskStatus);
  }
}
