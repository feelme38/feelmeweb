import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/data/repository/inventory/inventory_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class UpdateInventoryParam {
  final String userId;
  final InventoryResponse inventory;

  UpdateInventoryParam(this.userId, this.inventory);
}

class UpdateInventoryUseCase
    extends UseCaseParam<Result<bool>, UpdateInventoryParam> {
  final _repository = getIt<InventoryRepository>();

  @override
  Future<Result<bool>> call(UpdateInventoryParam param) {
    return _repository.updateInventory(param);
  }
}
