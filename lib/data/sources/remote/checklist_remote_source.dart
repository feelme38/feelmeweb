import 'package:dio/dio.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../../domain/checklists/get_last_checklists_usecase.dart';
import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/add_customer_address.dart';

@singleton
class ChecklistRemoteSource {
  final NetworkProvider _networkProvider;

  ChecklistRemoteSource(this._networkProvider);

  Future<Result<List<CheckListInfoResponse>>> getLastCheckListInfo(
      GetLastChecklistParam body) async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.lastChecklists,
          queryParams: {
            "customerId": body.customerId,
            // 'addressId': body.addressId
          });
      var result = (response.data as List)
          .map((e) => CheckListInfoResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

}
