import 'package:json_annotation/json_annotation.dart';
part 'address_dto.g.dart';
@JsonSerializable()
class AddressDTO {
  final String? id;
  final String? customerId;
  final String? address;
  final double? lat;
  final double? lon;

  AddressDTO({this.id, this.customerId, this.address, this.lat, this.lon});

  factory AddressDTO.fromJson(Map<String, dynamic> json) =>
      _$AddressDTOFromJson(json);
}
