import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class CreateUserUseCase extends UseCaseParam<Result<bool>, CreateUserBody> {
  final _repository = getIt<UsersRepository>();

  @override
  Future<Result<bool>> call(CreateUserBody param) {
    return _repository.createUser(param);
  }
}
