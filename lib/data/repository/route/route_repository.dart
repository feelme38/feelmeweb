import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/route/change_route_status_usecase.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
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
  Future<Result<bool>> updateRoute(RouteBody body) async {
    return await _routeRemoteSource.updateRoute(body: body);
  }

  @override
  Future<Result<List<TodayRouteResponse>>> getRoutesToday() =>
      _routeRemoteSource.getRoutesToday();

  @override
  Future<Result<RouteResponse>> getUserRoute(GetUserRouteParam param) =>
      _routeRemoteSource.getUserRoute(param);

  @override
  Future<Result<bool>> changeRouteStatus(RouteUpdateBody body) =>
      _routeRemoteSource.changeRouteStatus(body: body);
}

abstract class RouteRepository {
  Future<Result<bool>> createRoute(RouteBody body);
  Future<Result<bool>> updateRoute(RouteBody body);
  Future<Result<List<TodayRouteResponse>>> getRoutesToday();
  Future<Result<RouteResponse>> getUserRoute(GetUserRouteParam param);
  Future<Result<bool>> changeRouteStatus(RouteUpdateBody body);
}
