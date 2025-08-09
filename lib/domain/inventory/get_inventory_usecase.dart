import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/data/repository/inventory/inventory_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetInventoryUseCase extends UseCase<Result<InventoryResponse>> {
  final _repository = getIt<InventoryRepository>();

  @override
  Future<Result<InventoryResponse>> call() {
    return _repository.getInventory();
  }
}
