import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/create_region_body.dart';
import '../../sources/remote/regions_remote_source.dart';

@Singleton(as: RegionsRepository)
class RegionsRepositoryImpl extends RegionsRepository {
  final RegionsRemoteSource _regionsRemoteSource;

  RegionsRepositoryImpl(this._regionsRemoteSource);

  List<RegionResponse> _regions = [];

  @override
  Future<Result<List<RegionResponse>>> getRegions() async {
    final result = await _regionsRemoteSource.getRegions();
    if (result is Success<List<RegionResponse>>) {
      _regions = result.data;
    }
    return result;
  }

  @override
  List<RegionResponse> get regions => _regions;

  @override
  Future<Result<bool>> createRegion(CreateRegionBody body) =>
      _regionsRemoteSource.createRegion(body);
}

abstract class RegionsRepository {
  Future<Result<List<RegionResponse>>> getRegions();

  Future<Result<bool>> createRegion(CreateRegionBody body);

  List<RegionResponse> get regions;
}
