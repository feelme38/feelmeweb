
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/sources/remote/auth_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/auth_body.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {

  final AuthRemoteSource _remoteSource;

  AuthRepositoryImpl(this._remoteSource);

  @override
  Future<Result> login(AuthBody body) async {
    final result = await _remoteSource.login(body);
    result.doOnSuccess((value) async {
      await _remoteSource.saveToken(value.bearerToken);
    });
    return result;
  }

}

abstract class AuthRepository {
  Future<Result> login(AuthBody body);
}