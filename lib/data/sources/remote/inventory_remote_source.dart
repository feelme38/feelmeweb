import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/domain/inventory/update_inventory_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class InventoryRemoteSource {
  final NetworkProvider _networkProvider;

  InventoryRemoteSource(this._networkProvider);

  Future<Result<InventoryResponse>> getInventory() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.inventory);

      return Success(InventoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> updateInventory(UpdateInventoryParam param) async {
    try {
      await _networkProvider.dio.onPut(
        Urls.inventory,
        queryParams: {'userId': param.userId},
        data: param.inventory.toJson(),
      );

      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
