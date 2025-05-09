import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class DeleteUserUseCase extends UseCaseParam<Result<bool>, String> {
  final _repository = getIt<UsersRepository>();

  @override
  Future<Result<bool>> call(String userId) {
    return _repository.deleteUser(userId);
  }
}
