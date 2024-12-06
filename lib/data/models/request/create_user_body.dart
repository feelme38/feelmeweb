class CreateUserBody {
  final String phone;
  final String name;
  final String ownerName;
  final String regionId;

  CreateUserBody(
      {required this.phone,
      required this.name,
      required this.ownerName,
      required this.regionId});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'name': name,
        'ownerName': ownerName,
        'regionId': regionId
      };
}
