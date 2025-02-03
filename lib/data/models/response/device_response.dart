import 'package:json_annotation/json_annotation.dart';
import 'aroma_response.dart';

part 'device_response.g.dart';

@JsonSerializable()
class DeviceResponse {
  final String id;
  final AromaResponse? aroma;
  final String? powerType;
  final String? model;
  final double? aromaVolume;
  final String? contract;
  final String? place;
  final int? powerElementsCount;

  DeviceResponse({
    required this.id,
    this.aroma,
    this.powerType,
    this.model,
    this.aromaVolume,
    this.contract,
    this.place,
    this.powerElementsCount,
  });

  // Метод для десериализации JSON
  factory DeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseFromJson(json);

  // Метод для сериализации объекта в JSON
  Map<String, dynamic> toJson() => _$DeviceResponseToJson(this);
}
