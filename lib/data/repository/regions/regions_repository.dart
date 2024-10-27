
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:injectable/injectable.dart';

import '../../sources/remote/regions_remote_source.dart';

@Singleton(as: RegionsRepository)
class RegionsRepositoryImpl extends RegionsRepository {

  final RegionsRemoteSource _regionsRemoteSource;

  RegionsRepositoryImpl(this._regionsRemoteSource);

  @override
  Future<Result<List<RegionResponse>>> getRegions() async {
    return await _regionsRemoteSource.getRegions();
  }

}

abstract class RegionsRepository {
  Future<Result<List<RegionResponse>>> getRegions();
}