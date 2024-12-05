import 'package:feelmeweb/data/models/response/device_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';

part 'customer_response.g.dart';

@JsonSerializable()
class CustomerResponse {
  final String? id;
  final String? name;
  final String? phone;
  final String? ownerName;
  final String? preferredStartTime;
  final List<AddressDTO>? addresses;
  final List<DeviceResponse>? devices;
  final double? lat;
  final double? lon;

  CustomerResponse({
    required this.id,
    required this.name,
    required this.phone,
    required this.ownerName,
    required this.preferredStartTime,
    required this.addresses,
    required this.devices,
    this.lat,
    this.lon,
  });

  // Фабричный метод для десериализации JSON в объект ClientDto
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
}
