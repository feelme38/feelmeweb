import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class GetFilteredChecklistsParam {
  final String? engineerId;
  final String? createdDate;

  final String customerId;
  final int page;
  final int pageSize;
  GetFilteredChecklistsParam(
      {this.engineerId,
      this.createdDate,
      required this.customerId,
      required this.page,
      required this.pageSize});
}

class GetFilterChecklistsUseCase extends UseCaseParam<
    Result<PaginationChecklistsResponse>, GetFilteredChecklistsParam> {
  final _repository = getIt<ChecklistsRepository>();

  @override
  Future<Result<PaginationChecklistsResponse>> call(
          GetFilteredChecklistsParam param) =>
      _repository.getFilteredChecklists(param);
}
