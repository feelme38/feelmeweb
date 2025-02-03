import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/domain/tasks/delete_task_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class TasksRemoteSource {
  final NetworkProvider _networkProvider;

  TasksRemoteSource(this._networkProvider);

  Future<Result<List<TaskTypeResponse>>> getTypes() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.taskTypes);
      var result = (response.data as List)
          .map((e) => TaskTypeResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> deleteTask(DeleteTaskParam param) async {
    try {
      await _networkProvider.dio.onDelete('${Urls.task}/${param.userId}');

      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
