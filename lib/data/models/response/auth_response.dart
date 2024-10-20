import 'package:json_annotation/json_annotation.dart';
part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String bearerToken;
  AuthResponse(this.bearerToken);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}