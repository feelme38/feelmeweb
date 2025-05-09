import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/create_user_body.dart';
import '../../models/response/roles_response.dart';

@Singleton(as: UsersRepository)
class UsersRepositoryImpl extends UsersRepository {
  final UsersRemoteSource _usersRemoteSource;

  UsersRepositoryImpl(this._usersRemoteSource);

  @override
  List<RolesResponse> roles = [];

  @override
  Future<Result<List<UserResponse>>> getUsers(String? roleId) async {
    return await _usersRemoteSource.getUsers(roleId);
  }

  @override
  Future<Result<List<RolesResponse>>> getUserRoles() async {
    final result = await _usersRemoteSource.getUserRoles();
    if (result is Success<List<RolesResponse>>) {
      roles = result.data;
    }
    return result;
  }

  @override
  Future<Result<bool>> createUser(CreateUserBody body) {
    return _usersRemoteSource.createUser(body);
  }

  @override
  Future<Result<bool>> deleteUser(String userId) {
    return _usersRemoteSource.deleteUser(userId);
  }
}

abstract class UsersRepository {
  Future<Result<List<UserResponse>>> getUsers(String? roleId);
  Future<Result<bool>> createUser(CreateUserBody body);
  Future<Result<List<RolesResponse>>> getUserRoles();
  Future<Result<bool>> deleteUser(String userId);

  List<RolesResponse> get roles;
}
