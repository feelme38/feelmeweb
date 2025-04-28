class CreateAromaBody {
  final String? id;
  final String name;
  final String type;

  CreateAromaBody({required this.name, required this.type, this.id});

  Map<String, dynamic> toJson() => {'name': name, 'type': type, 'id': id};
}
