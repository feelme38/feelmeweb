import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/repository/route/route_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class ChangeRouteStatusParam {
  final String userId;
  final String status;

  ChangeRouteStatusParam(this.userId, this.status);
}

class ChangeRouteStatusUseCase
    extends UseCaseParam<Result<bool>, RouteUpdateBody> {
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<bool>> call(RouteUpdateBody param) =>
      _repository.changeRouteStatus(param);
}
