import 'package:json_annotation/json_annotation.dart';

part 'customer_response.g.dart';

@JsonSerializable()
class CustomerResponse {
  final String id;
  final String name;
  final String phone;
  final String ownerName;
  final String preferredStartTime;
  final String address;
  final double? lat;
  final double? lon;

  CustomerResponse({
    required this.id,
    required this.name,
    required this.phone,
    required this.ownerName,
    required this.preferredStartTime,
    required this.address,
    this.lat,
    this.lon,
  });

  // Фабричный метод для десериализации JSON в объект ClientDto
  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);
}
