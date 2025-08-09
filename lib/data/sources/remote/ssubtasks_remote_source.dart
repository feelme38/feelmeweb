import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/domain/subtasks/delete_subtask_usecase.dart';
import 'package:feelmeweb/provider/network/network_provider.dart';
import 'package:feelmeweb/provider/network/urls.dart';
import 'package:injectable/injectable.dart';

@singleton
class SubtasksRemoteSource {
  final NetworkProvider _networkProvider;

  SubtasksRemoteSource(this._networkProvider);

  Future<Result<List<SubtaskTypeResponse>>> getTypes() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.subtaskTypes);
      var result = (response.data as List)
          .map((e) => SubtaskTypeResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

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
