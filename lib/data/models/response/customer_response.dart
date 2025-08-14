import 'package:feelmeweb/data/models/response/device_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
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
  final RegionResponse? region;

  CustomerResponse({
    required this.id,
    this.name,
    this.phone,
    this.ownerName,
    this.preferredStartTime,
    this.addresses,
    this.devices,
    this.lat,
    this.lon,
    this.region,
  });

  /// Метод для создания новой копии объекта с изменёнными полями
  CustomerResponse copyWith({
    String? id,
    String? name,
    String? phone,
    String? ownerName,
    String? preferredStartTime,
    List<AddressDTO>? addresses,
    List<DeviceResponse>? devices,
    double? lat,
    double? lon,
    RegionResponse? region,
  }) {
    return CustomerResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      ownerName: ownerName ?? this.ownerName,
      preferredStartTime: preferredStartTime ?? this.preferredStartTime,
      addresses: addresses ?? this.addresses,
      devices: devices ?? this.devices,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      region: region ?? this.region,
    );
  }

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}
