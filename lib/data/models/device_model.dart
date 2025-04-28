class DeviceModel {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeviceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
