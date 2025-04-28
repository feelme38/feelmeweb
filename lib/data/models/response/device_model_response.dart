import 'package:json_annotation/json_annotation.dart';

part 'device_model_response.g.dart';

@JsonSerializable()
class DeviceModelResponse {
  final String id;
  final String name;
  final String workerType;

  DeviceModelResponse({
    required this.id,
    required this.name,
    required this.workerType,
  });

  factory DeviceModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelResponseToJson(this);
}

@JsonEnum()
enum WorkerType { FULL, LITE }
