import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetAvailableRegionsUseCase
    extends UseCaseParam<Result<List<RegionResponse>>, String> {
  final _repository = getIt<RegionsRepository>();

  @override
  Future<Result<List<RegionResponse>>> call(String param) {
    return _repository.getAvailableRegions(param);
  }
}
