import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/domain/subtasks/delete_subtask_usecase.dart';
import 'package:feelmeweb/provider/network/network_provider.dart';
import 'package:feelmeweb/provider/network/urls.dart';
import 'package:injectable/injectable.dart';

@singleton
class SubtasksRemoteSource {
  final NetworkProvider _networkProvider;

  SubtasksRemoteSource(this._networkProvider);

  Future<Result<bool>> deleteSubtask(DeleteSubtaskParam param) async {
    try {
      await _networkProvider.dio.onDelete('${Urls.subtask}/${param.userId}');
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
