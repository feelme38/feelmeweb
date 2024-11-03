import 'package:dio/dio.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class ChecklistRemoteSource {
  final NetworkProvider _networkProvider;

  ChecklistRemoteSource(this._networkProvider);

  Future<Result<List<CheckListInfoResponse>>> getLastCheckListInfo(String customerId) async {
    try {
      final response = await _networkProvider.dio.onGet(
        Urls.lastChecklists,
        queryParams: { "customerId": customerId }
      );
      var result =
      (response.data as List).map((e) => CheckListInfoResponse.fromJson(e)).toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

}