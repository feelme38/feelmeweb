import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/data/sources/remote/inventory_remote_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: InventoryRepository)
class InventoryRepositoryImpl extends InventoryRepository {
  final InventoryRemoteSource _inventoryRemoteSource;

  InventoryRepositoryImpl(this._inventoryRemoteSource);

  @override
  Future<Result<InventoryResponse>> getInventory() async {
    return await _inventoryRemoteSource.getInventory();
  }
}

abstract class InventoryRepository {
  Future<Result<InventoryResponse>> getInventory();
}
