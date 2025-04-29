import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_device_model_body.g.dart';

@JsonSerializable()
class CreateDeviceModelBody {
  final String name;
  final WorkerType worker_type;

  CreateDeviceModelBody({required this.name, required this.worker_type});

  factory CreateDeviceModelBody.fromJson(Map<String, dynamic> json) =>
      _$CreateDeviceModelBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDeviceModelBodyToJson(this);
}
