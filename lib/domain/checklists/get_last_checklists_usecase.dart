
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart';

import '../../core/result/result_of.dart';
import '../../provider/di/di_provider.dart';
import '../base_use_case.dart';
class GetLastChecklistParam {
  final String customerId;
  final String addressId;

  GetLastChecklistParam(this.addressId, this.customerId);
}

class GetLastChecklistsUseCase extends UseCaseParam<Result<List<CheckListInfoResponse>>, GetLastChecklistParam> {

  final _repository = getIt<ChecklistsRepository>();

  @override
  Future<Result<List<CheckListInfoResponse>>> call(GetLastChecklistParam param) {
    return _repository.getLastCheckListInfo(param);
  }

}