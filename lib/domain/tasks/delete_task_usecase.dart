import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/tasks/tasks_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class DeleteTaskParam {
  final String userId;

  DeleteTaskParam(this.userId);
}

class DeleteTaskUseCase extends UseCaseParam<Result<bool>, DeleteTaskParam> {
  final _repository = getIt<TasksRepository>();

  @override
  Future<Result<bool>> call(DeleteTaskParam param) {
    return _repository.deleteTask(param);
  }
}
