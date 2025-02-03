
import 'package:json_annotation/json_annotation.dart';
part 'subtask_body.g.dart';

@JsonSerializable()
class SubtaskBody {

  final String? customerId;
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
      this.estimatedCompletedTime
  );

  factory SubtaskBody.fromJson(Map<String, dynamic> json) => _$SubtaskBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskBodyToJson(this);
}