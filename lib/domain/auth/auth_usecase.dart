
import 'package:feelmeweb/data/repository/auth/auth_repository.dart';

import '../../core/result/result_of.dart';
import '../../data/models/request/AuthBody.dart';
import '../../provider/di/di_provider.dart';
import '../base_use_case.dart';

class AuthUseCase extends UseCaseParam<Result, AuthBody> {
  final _repository = getIt<AuthRepository>();

  @override
  Future<Result> call(AuthBody param) {
    return _repository.login(param);
  }
}