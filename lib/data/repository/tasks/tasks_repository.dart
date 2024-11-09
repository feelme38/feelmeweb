
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../sources/remote/tasks_remote_source.dart';

@Singleton(as: TasksRepository)
class TasksRepositoryImpl extends TasksRepository {

  final TasksRemoteSource _tasksRemoteSource;

  TasksRepositoryImpl(this._tasksRemoteSource);

  @override
  Future<Result<List<TaskTypeResponse>>> getTypes() async {
    return await _tasksRemoteSource.getTypes();
  }

}

abstract class TasksRepository {
  Future<Result<List<TaskTypeResponse>>> getTypes();
}