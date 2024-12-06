
class DevicePowersResponse {
  final String name;
  final String id;

  DevicePowersResponse(this.name, this.id);

  factory DevicePowersResponse.fromJson(Map<String, dynamic> json) {
    return DevicePowersResponse(
      json['name'],
      json['id'],
    );
  }
}
class DeviceModelsResponse {
  final String name;
  final String id;

  DeviceModelsResponse(this.name, this.id);

  factory DeviceModelsResponse.fromJson(Map<String, dynamic> json) {
    return DeviceModelsResponse(
      json['name'],
      json['id'],
    );
  }
}