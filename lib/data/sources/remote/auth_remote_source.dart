import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/AuthBody.dart';
import '../../models/response/auth_response.dart';

@singleton
class AuthRemoteSource {
  final NetworkProvider _networkProvider;

  AuthRemoteSource(this._networkProvider);

  Future<Result<AuthResponse>> login(AuthBody body) async {
    try {
      final response = await _networkProvider.dio.onPost(
          Urls.login,
          data: body.toJson()
      );
      return Success(AuthResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<void> saveToken(String login) =>
      _networkProvider.preferences.saveToken(login);
}