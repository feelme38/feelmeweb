import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:feelmeweb/data/sources/remote/checklist_remote_source.dart';
import 'package:feelmeweb/domain/checklists/get_available_checklists_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_checklists_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_filtered_checklists_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/checklists/get_last_checklists_usecase.dart';

@Singleton(as: ChecklistsRepository)
class ChecklistsRepositoryImpl extends ChecklistsRepository {
  final ChecklistRemoteSource _checklistsRemoteSource;

  ChecklistsRepositoryImpl(this._checklistsRemoteSource);

  @override
  Future<Result<List<LastCheckListInfoResponse>>> getLastCheckListInfo(
      GetLastChecklistParam param) async {
    return await _checklistsRemoteSource.getLastCheckListInfo(param);
  }

  @override
  Future<Result<List<LastCheckListInfoResponse>>> getAvailableCheckListInfo(
      GetAvailableChecklistParam param) async {
    return await _checklistsRemoteSource.getAvailableCheckListInfo(param);
  }

  @override
  Future<Result<List<CheckListInfoResponse>>> getChecklistsInfo(
      GetChecklistParam param) async {
    return await _checklistsRemoteSource.getChecklistsInfo(param);
  }

  @override
  Future<Result<PaginationChecklistsResponse>> getFilteredChecklists(
          GetFilteredChecklistsParam param) =>
      _checklistsRemoteSource.getFilteredChecklists(param);
}

abstract class ChecklistsRepository {
  Future<Result<List<LastCheckListInfoResponse>>> getLastCheckListInfo(
      GetLastChecklistParam param);
  Future<Result<List<LastCheckListInfoResponse>>> getAvailableCheckListInfo(
      GetAvailableChecklistParam param);
  Future<Result<List<CheckListInfoResponse>>> getChecklistsInfo(
      GetChecklistParam param);
  Future<Result<PaginationChecklistsResponse>> getFilteredChecklists(
      GetFilteredChecklistsParam param);
}
