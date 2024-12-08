import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

import '../../data/models/request/create_region_body.dart';

class CreateRegionUseCase extends UseCaseParam<Result<bool>, CreateRegionBody> {
  final _repository = getIt<RegionsRepository>();

  @override
  Future<Result<bool>> call(CreateRegionBody param) =>
      _repository.createRegion(param);
}
