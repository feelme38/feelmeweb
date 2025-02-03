
class CreateAromaBody {
  final String name;

  CreateAromaBody({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
}