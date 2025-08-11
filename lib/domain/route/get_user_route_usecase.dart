import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/repository/route/route_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class GetUserRouteParam {
  final String userId;
  final String routeDate;
  GetUserRouteParam(this.userId, this.routeDate);
}

class GetUserRouteUseCase
    extends UseCaseParam<Result<RouteResponse>, GetUserRouteParam> {
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<RouteResponse>> call(GetUserRouteParam param) =>
      _repository.getUserRoute(param);
}

class GetUserRoutesUseCase
    extends UseCaseParam<Result<List<RouteResponse>>, String> {
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<List<RouteResponse>>> call(String userId) =>
      _repository.getUserRoutes(userId);
}