import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/update_region_body.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class UpdateRegionUseCase extends UseCaseParam<Result<bool>, UpdateRegionBody> {
  final _repository = getIt<RegionsRepository>();

  @override
  Future<Result<bool>> call(UpdateRegionBody param) {
    return _repository.updateRegion(param);
  }
}
