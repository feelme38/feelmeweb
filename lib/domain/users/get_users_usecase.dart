
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetUsersUseCase extends UseCaseNameParam<Result<List<UserResponse>>, String?> {

  final _repository = getIt<UsersRepository>();

  @override
  Future<Result<List<UserResponse>>> call({String? param}) {
    return _repository.getUsers(param);
  }

}