
import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class UsersRemoteSource {
  final NetworkProvider _networkProvider;

  UsersRemoteSource(this._networkProvider);

  Future<Result<List<UserResponse>>> getUsers(String? roleId) async {
    try {
      final response = await _networkProvider.dio.onGet(
          Urls.users,
          queryParams: {
            "roleId": roleId
          }
      );
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