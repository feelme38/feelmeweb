import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/data/sources/remote/ssubtasks_remote_source.dart';
import 'package:feelmeweb/domain/subtasks/delete_subtask_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';

@Singleton(as: SubtasksRepository)
class SubtasksRepositoryImpl extends SubtasksRepository {
  final SubtasksRemoteSource _subtasksRemoteSource;

  SubtasksRepositoryImpl(this._subtasksRemoteSource);

  @override
  Future<Result<List<SubtaskTypeResponse>>> getTypes() async {
    return await _subtasksRemoteSource.getTypes();
  }

  @override
  Future<Result<bool>> deleteSubtask(DeleteSubtaskParam param) async {
    return await _subtasksRemoteSource.deleteSubtask(param);
  }
}

abstract class SubtasksRepository {
  Future<Result<List<SubtaskTypeResponse>>> getTypes();
  Future<Result<bool>> deleteSubtask(DeleteSubtaskParam param);
}
