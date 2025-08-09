import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/roles_response.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class GetRolesUseCase extends UseCase<Result<List<RolesResponse>>> {
  final _repository = getIt<UsersRepository>();

  @override
  Future<Result<List<RolesResponse>>> call() => _repository.getUserRoles();
}
