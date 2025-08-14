import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/response/pagination_routes_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/route/get_filtered_routes_usecase.dart';
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
  Future<Result<PaginationRoutesResponse>> getFilteredRoutes(
          GetFilteredRoutesParam param) =>
      _routeRemoteSource.getFilteredRoutes(param);

  @override
  Future<Result<List<RouteResponse>>> getUserRoutes(String userId) =>
      _routeRemoteSource.getUserRoutes(userId);

  @override
  Future<Result<RouteResponse>> getRouteById(String routeId) =>
      _routeRemoteSource.getRouteById(routeId);

  @override
  Future<Result<bool>> changeRouteStatus(RouteUpdateBody body) =>
      _routeRemoteSource.changeRouteStatus(body: body);
}

abstract class RouteRepository {
  Future<Result<bool>> createRoute(RouteBody body);
  Future<Result<bool>> updateRoute(RouteBody body);
  Future<Result<List<TodayRouteResponse>>> getRoutesToday();
  Future<Result<RouteResponse>> getUserRoute(GetUserRouteParam param);
  Future<Result<PaginationRoutesResponse>> getFilteredRoutes(
      GetFilteredRoutesParam param);
  Future<Result<List<RouteResponse>>> getUserRoutes(String userId);
  Future<Result<RouteResponse>> getRouteById(String routeId);
  Future<Result<bool>> changeRouteStatus(RouteUpdateBody body);
}
