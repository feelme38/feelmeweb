import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/subtasks/ssubtasks_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class DeleteSubtaskParam {
  final String userId;

  DeleteSubtaskParam(this.userId);
}

class DeleteSubtaskUseCase
    extends UseCaseParam<Result<bool>, DeleteSubtaskParam> {
  final _repository = getIt<SubtasksRepository>();

  @override
  Future<Result<bool>> call(DeleteSubtaskParam param) {
    return _repository.deleteSubtask(param);
  }
}
