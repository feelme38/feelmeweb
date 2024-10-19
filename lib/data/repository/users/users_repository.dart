
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UsersRepository)
class UsersRepositoryImpl extends UsersRepository {

  final UsersRemoteSource _usersRemoteSource;

  UsersRepositoryImpl(this._usersRemoteSource);

  @override
  Future<Result<List<UserResponse>>> getUsers(String? roleId) async {
    return await _usersRemoteSource.getUsers(roleId);
  }

}

abstract class UsersRepository {
  Future<Result<List<UserResponse>>> getUsers(String? roleId);
}