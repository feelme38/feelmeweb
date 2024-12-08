
class RolesResponse {
  final String id;
  final String name;

  RolesResponse({required this.id, required this.name});

  factory RolesResponse.fromJson(Map<String, dynamic> json) {
    return RolesResponse(id: json['id'], name: json['name']);
  }
}