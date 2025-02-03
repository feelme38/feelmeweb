import 'package:json_annotation/json_annotation.dart';

part 'inventory_response.g.dart';

@JsonSerializable()
class Aroma {
  final String? id; // Убедитесь, что это nullable
  final String? name; // Убедитесь, что это nullable

  Aroma({this.id, this.name});

  factory Aroma.fromJson(Map<String, dynamic> json) => _$AromaFromJson(json);

  Map<String, dynamic> toJson() => _$AromaToJson(this);
}

@JsonSerializable()
class AromaQuantity {
  final Aroma? aroma;
  final double? quantity; // Убедитесь, что это nullable

  AromaQuantity({this.aroma, this.quantity});

  factory AromaQuantity.fromJson(Map<String, dynamic> json) =>
      _$AromaQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$AromaQuantityToJson(this);
}

@JsonSerializable()
class DeviceAroma {
  final String? id; // Убедитесь, что это nullable
  final String? name; // Убедитесь, что это nullable

  DeviceAroma({this.id, this.name});

  factory DeviceAroma.fromJson(Map<String, dynamic> json) =>
      _$DeviceAromaFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceAromaToJson(this);
}

@JsonSerializable()
class Device {
  final String? id; // Убедитесь, что это nullable
  final String? powerType; // Убедитесь, что это nullable
  final String? model; // Убедитесь, что это nullable
  final double? aromaVolume; // Убедитесь, что это nullable
  final String? contract; // Убедитесь, что это nullable
  final String? place; // Убедитесь, что это nullable
  final DeviceAroma? aroma;

  Device({
    this.id,
    this.powerType,
    this.model,
    this.aromaVolume,
    this.contract,
    this.place,
    this.aroma,
  });

  factory Device.fromJson(Map<String, dynamic> json) =>
      _$DeviceFromJson(json['device'] ?? json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable()
class InventoryResponse {
  final List<AromaQuantity> aromas;
  final List<Device> devices;
  final List<String> instruments;
  final List<String> materials;
  final List<String> other;

  InventoryResponse({
    required this.aromas,
    required this.devices,
    required this.instruments,
    required this.materials,
    required this.other,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      _$InventoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryResponseToJson(this);
}
