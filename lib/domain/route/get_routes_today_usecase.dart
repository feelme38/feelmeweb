
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/route/route_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

import '../../data/models/response/today_routes_response.dart';

class GetRoutesTodayUseCase extends UseCase<Result<List<TodayRouteResponse>>>{
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<List<TodayRouteResponse>>> call() => _repository.getRoutesToday();
}