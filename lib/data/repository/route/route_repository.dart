
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/sources/remote/devices_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../models/response/today_routes_response.dart';
import '../../sources/remote/route_remote_source.dart';

@Singleton(as: RouteRepository)
class RouteRepositoryImpl extends RouteRepository {

  final RouteRemoteSource _routeRemoteSource;

  RouteRepositoryImpl(this._routeRemoteSource);

  @override
  Future<Result<bool>> createRoute(RouteBody body) async {
    return await _routeRemoteSource.createRoute(body: body);
  }

  @override
  Future<Result<List<TodayRouteResponse>>> getRoutesToday() => _routeRemoteSource.getRoutesToday();

}

abstract class RouteRepository {
  Future<Result<bool>> createRoute(RouteBody body);
  Future<Result<List<TodayRouteResponse>>> getRoutesToday();
}