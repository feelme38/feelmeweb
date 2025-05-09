import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/repository/route/route_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class UpdateRouteUseCase extends UseCaseParam<Result<bool>, RouteBody> {
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<bool>> call(RouteBody param) {
    return _repository.updateRoute(param);
  }
}
