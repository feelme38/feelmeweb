class AuthBody {
  final String user;
  final String password;

  AuthBody(this.user, this.password);

  Map<String, dynamic> toJson() {
    return {'password': password, 'email': user};
  }

}