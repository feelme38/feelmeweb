import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_region_body.dart';
import 'package:feelmeweb/data/models/request/update_region_body.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/regions/get_available_regions_usecase.dart';
import 'package:injectable/injectable.dart';

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
  Future<Result<List<RegionResponse>>> getAvailableRegions(
      GetAvailableRegionsParams param) async {
    final result = await _regionsRemoteSource.getAvailableRegions(param);
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

  @override
  Future<Result<bool>> updateRegion(UpdateRegionBody body) =>
      _regionsRemoteSource.updateRegion(body);

  @override
  Future<Result<bool>> deleteRegion(String id) =>
      _regionsRemoteSource.deleteRegion(id);
}

abstract class RegionsRepository {
  Future<Result<List<RegionResponse>>> getRegions();

  Future<Result<List<RegionResponse>>> getAvailableRegions(
      GetAvailableRegionsParams param);

  Future<Result<bool>> createRegion(CreateRegionBody body);

  Future<Result<bool>> updateRegion(UpdateRegionBody body);

  Future<Result<bool>> deleteRegion(String id);

  List<RegionResponse> get regions;
}
