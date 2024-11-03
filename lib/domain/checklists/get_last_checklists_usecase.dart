
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart';

import '../../core/result/result_of.dart';
import '../../provider/di/di_provider.dart';
import '../base_use_case.dart';

class GetLastChecklistsUseCase extends UseCaseParam<Result<List<CheckListInfoResponse>>, String> {

  final _repository = getIt<ChecklistsRepository>();

  @override
  Future<Result<List<CheckListInfoResponse>>> call(String param) {
    return _repository.getLastCheckListInfo(param);
  }

}