import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/pagination_routes_response.dart';
import 'package:feelmeweb/data/repository/route/route_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class GetFilteredRoutesParam {
  final String? userId;
  final String? assignDate;
  final String? routeStatus;
  final int page;
  final int pageSize;
  GetFilteredRoutesParam(
      {this.userId,
      this.assignDate,
      this.routeStatus,
      required this.page,
      required this.pageSize});
}

class GetFilterRoutesUseCase extends UseCaseParam<
    Result<PaginationRoutesResponse>, GetFilteredRoutesParam> {
  final _repository = getIt<RouteRepository>();

  @override
  Future<Result<PaginationRoutesResponse>> call(GetFilteredRoutesParam param) =>
      _repository.getFilteredRoutes(param);
}
