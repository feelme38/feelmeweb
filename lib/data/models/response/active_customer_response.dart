import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'active_customer_response.g.dart';

@JsonSerializable()
class ActiveCustomerResponse {
  final Client customer;
  final List<Subtask> subtasks;

  ActiveCustomerResponse({
    required this.customer,
    required this.subtasks,
  });

  factory ActiveCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveCustomerResponseToJson(this);
}
