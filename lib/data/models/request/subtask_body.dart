import 'package:json_annotation/json_annotation.dart';

part 'subtask_body.g.dart';

@JsonSerializable()
class SubtaskBody {
  final String? id;
  final String? customerId;
  final String? addressId;
  final String deviceId;
  final String comment;
  final String expectedAromaId;
  final double expectedAromaVolume;
  final int estimatedCompletedTime;

  SubtaskBody(
    this.customerId,
    this.deviceId,
    this.comment,
    this.expectedAromaId,
    this.expectedAromaVolume,
    this.estimatedCompletedTime, {
    this.id,
    this.addressId,
  });

  factory SubtaskBody.fromJson(Map<String, dynamic> json) =>
      _$SubtaskBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SubtaskBodyToJson(this);

  /// Метод copyWith для создания изменённых копий объекта
  SubtaskBody copyWith({
    String? id,
    String? customerId,
    String? addressId,
    String? deviceId,
    String? comment,
    String? expectedAromaId,
    double? expectedAromaVolume,
    int? estimatedCompletedTime,
  }) {
    return SubtaskBody(
      customerId ?? this.customerId,
      deviceId ?? this.deviceId,
      comment ?? this.comment,
      expectedAromaId ?? this.expectedAromaId,
      expectedAromaVolume ?? this.expectedAromaVolume,
      estimatedCompletedTime ?? this.estimatedCompletedTime,
      id: id ?? this.id,
      addressId: addressId ?? this.addressId,
    );
  }
}
