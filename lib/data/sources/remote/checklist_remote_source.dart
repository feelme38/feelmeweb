import 'package:dio/dio.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/domain/checklists/get_available_checklists_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_checklists_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../core/result/result_of.dart';
import '../../../domain/checklists/get_last_checklists_usecase.dart';
import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class ChecklistRemoteSource {
  final NetworkProvider _networkProvider;

  ChecklistRemoteSource(this._networkProvider);

  Future<Result<List<LastCheckListInfoResponse>>> getLastCheckListInfo(
      GetLastChecklistParam body) async {
    try {
      final response =
          await _networkProvider.dio.onGet(Urls.lastChecklists, queryParams: {
        // "customerId": body.customerId,
        'addressId': body.addressId
      });
      var result = (response.data as List)
          .map((e) => LastCheckListInfoResponse.fromJson(e)
              .copyWith(addressId: body.addressId, customerId: body.customerId))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<List<LastCheckListInfoResponse>>> getAvailableCheckListInfo(
      GetAvailableChecklistParam body) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.availableChecklists, queryParams: {
        "userId": body.userId,
        'addressId': body.addressId,
        'routeDate': body.routeDate
      });
      var result = (response.data as List)
          .map((e) => LastCheckListInfoResponse.fromJson(e)
              .copyWith(addressId: body.addressId, customerId: body.customerId))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<List<CheckListInfoResponse>>> getChecklistsInfo(
      GetChecklistParam body) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.checklists, queryParams: {'userId': body.userId});
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
