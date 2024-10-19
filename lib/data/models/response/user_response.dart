import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String id;
  final String name;

  UserResponse(this.id, this.name);

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
}