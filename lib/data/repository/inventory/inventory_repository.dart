import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/data/sources/remote/inventory_remote_source.dart';
import 'package:feelmeweb/domain/inventory/update_inventory_usecase.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: InventoryRepository)
class InventoryRepositoryImpl extends InventoryRepository {
  final InventoryRemoteSource _inventoryRemoteSource;

  InventoryRepositoryImpl(this._inventoryRemoteSource);

  @override
  Future<Result<InventoryResponse>> getInventory() async {
    return await _inventoryRemoteSource.getInventory();
  }

  @override
  Future<Result<bool>> updateInventory(UpdateInventoryParam param) async {
    return await _inventoryRemoteSource.updateInventory(param);
  }
}

abstract class InventoryRepository {
  Future<Result<InventoryResponse>> getInventory();
  Future<Result<bool>> updateInventory(UpdateInventoryParam param);
}
