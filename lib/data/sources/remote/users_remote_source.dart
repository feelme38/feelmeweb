import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/response/roles_response.dart';

@singleton
class UsersRemoteSource {
  final NetworkProvider _networkProvider;

  UsersRemoteSource(this._networkProvider);

  Future<Result<List<UserResponse>>> getUsers(String? roleId) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.users, queryParams: {"roleId": roleId});
      var result =
          (response.data as List).map((e) => UserResponse.fromJson(e)).toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<List<RolesResponse>>> getUserRoles() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.roles);

      var result = (response.data as List)
          .map((e) => RolesResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> createUser(CreateUserBody body) async {
    try {
      await _networkProvider.dio.onPost(Urls.signUpUser, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result> deleteUser(String? userId) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.users, queryParams: {"roleId": userId});
      var result =
          (response.data as List).map((e) => UserResponse.fromJson(e)).toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
