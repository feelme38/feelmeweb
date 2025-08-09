import 'package:json_annotation/json_annotation.dart';

part 'update_customer_body.g.dart';

@JsonSerializable()
class UpdateCustomerBody {
  final String id;
  final String name;
  final String ownerName;
  final String phone;
  final String regionId;

  UpdateCustomerBody({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.phone,
    required this.regionId,
  });

  factory UpdateCustomerBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateCustomerBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCustomerBodyToJson(this);
}
