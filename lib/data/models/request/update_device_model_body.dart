import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_device_model_body.g.dart';

@JsonSerializable()
class UpdateDeviceModelBody {
  final String id;
  final String name;
  final WorkerType worker_type;

  UpdateDeviceModelBody({
    required this.id,
    required this.name,
    required this.worker_type,
  });

  factory UpdateDeviceModelBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateDeviceModelBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDeviceModelBodyToJson(this);
}
