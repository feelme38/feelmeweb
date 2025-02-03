class CreateRegionBody {
  final String name;

  CreateRegionBody({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
}
