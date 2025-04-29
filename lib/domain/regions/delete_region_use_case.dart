import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class DeleteRegionUseCase extends UseCaseParam<Result<bool>, String> {
  final _repository = getIt<RegionsRepository>();

  @override
  Future<Result<bool>> call(String param) {
    return _repository.deleteRegion(param);
  }
}
