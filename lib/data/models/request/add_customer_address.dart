import 'package:json_annotation/json_annotation.dart';

part 'add_customer_address.g.dart';

@JsonSerializable()
class AddCustomerAddressBody {
  final String customerId;
  final String address;

  AddCustomerAddressBody(this.customerId, this.address);

  factory AddCustomerAddressBody.fromJson(Map<String, dynamic> json) =>
      _$AddCustomerAddressBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddCustomerAddressBodyToJson(this);
}
