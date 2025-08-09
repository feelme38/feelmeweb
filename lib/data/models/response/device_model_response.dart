import 'package:json_annotation/json_annotation.dart';

part 'device_model_response.g.dart';

@JsonSerializable()
class DeviceModelResponse {
  final String id;
  final String name;
  final WorkerType? worker_type;

  DeviceModelResponse({
    required this.id,
    required this.name,
    this.worker_type,
  });

  factory DeviceModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelResponseToJson(this);
}

@JsonEnum()
enum WorkerType { FULL, LITE }
