import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/data/repository/subtasks/ssubtasks_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetSubtaskTypesUseCase
    extends UseCase<Result<List<SubtaskTypeResponse>>> {
  final _repository = getIt<SubtasksRepository>();

  @override
  Future<Result<List<SubtaskTypeResponse>>> call() {
    return _repository.getTypes();
  }
}
