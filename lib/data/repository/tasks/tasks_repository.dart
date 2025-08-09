import 'package:feelmeweb/domain/tasks/delete_task_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../sources/remote/tasks_remote_source.dart';

@Singleton(as: TasksRepository)
class TasksRepositoryImpl extends TasksRepository {
  final TasksRemoteSource _tasksRemoteSource;

  TasksRepositoryImpl(this._tasksRemoteSource);

  @override
  Future<Result<bool>> deleteTask(DeleteTaskParam param) async {
    return await _tasksRemoteSource.deleteTask(param);
  }
}

abstract class TasksRepository {
  Future<Result<bool>> deleteTask(DeleteTaskParam param);
}
