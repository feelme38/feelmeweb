import 'package:json_annotation/json_annotation.dart';

part 'create_customer_body.g.dart';

@JsonSerializable()
class CreateCustomerBody {
  final String name;
  final String email;
  final String phone;
  final String address;

  CreateCustomerBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory CreateCustomerBody.fromJson(Map<String, dynamic> json) =>
      _$CreateCustomerBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomerBodyToJson(this);
}
