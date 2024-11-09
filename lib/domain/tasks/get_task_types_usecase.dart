
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart';
import 'package:feelmeweb/data/repository/tasks/tasks_repository.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetTaskTypesUseCase extends UseCase<Result<List<TaskTypeResponse>>> {

  final _repository = getIt<TasksRepository>();

  @override
  Future<Result<List<TaskTypeResponse>>> call() {
    return _repository.getTypes();
  }

}