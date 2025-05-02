import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart';

import '../../core/result/result_of.dart';
import '../../provider/di/di_provider.dart';
import '../base_use_case.dart';

class GetChecklistParam {
  final String userId;

  GetChecklistParam(this.userId);
}

class GetChecklistsUseCase extends UseCaseParam<
    Result<List<CheckListInfoResponse>>, GetChecklistParam> {
  final _repository = getIt<ChecklistsRepository>();

  @override
  Future<Result<List<CheckListInfoResponse>>> call(GetChecklistParam param) {
    return _repository.getChecklistsInfo(param);
  }
}
