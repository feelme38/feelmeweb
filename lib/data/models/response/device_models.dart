import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_models.g.dart';

@JsonSerializable()
class DeviceModelsResponse {
  final String id;
  final String name;
  final WorkerType worker_type;

  DeviceModelsResponse({
    required this.id,
    required this.name,
    required this.worker_type,
  });

  // Метод для десериализации JSON
  factory DeviceModelsResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelsResponseFromJson(json);

  // Метод для сериализации объекта в JSON
  Map<String, dynamic> toJson() => _$DeviceModelsResponseToJson(this);
}
