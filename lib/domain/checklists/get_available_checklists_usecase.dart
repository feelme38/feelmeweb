import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/repository/checklists/checklists_repository.dart';

import '../../core/result/result_of.dart';
import '../../provider/di/di_provider.dart';
import '../base_use_case.dart';

class GetAvailableChecklistParam {
  final String userId;
  final String customerId;
  final String addressId;

  GetAvailableChecklistParam(this.addressId, this.customerId, this.userId);
}

class GetAvailableChecklistsUseCase extends UseCaseParam<
    Result<List<LastCheckListInfoResponse>>, GetAvailableChecklistParam> {
  final _repository = getIt<ChecklistsRepository>();

  @override
  Future<Result<List<LastCheckListInfoResponse>>> call(
      GetAvailableChecklistParam param) {
    return _repository.getAvailableCheckListInfo(param);
  }
}
