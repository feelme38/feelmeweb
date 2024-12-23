class CreateCustomerBody {
  final String phone;
  final String name;
  final String ownerName;
  final String regionId;

  CreateCustomerBody(
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

class CreateUserBody {
  final String name;
  final String email;
  final String password;
  final String typeId;

  CreateUserBody(
      {required this.name,
      required this.email,
      required this.password,
      required this.typeId});

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'password': password, 'typeId': typeId};
}
