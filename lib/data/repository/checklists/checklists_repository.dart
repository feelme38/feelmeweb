
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/add_customer_address.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart';
import 'package:feelmeweb/data/sources/remote/checklist_remote_source.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/checklists/get_last_checklists_usecase.dart';
import '../../sources/remote/customers_remote_source.dart';

@Singleton(as: ChecklistsRepository)
class ChecklistsRepositoryImpl extends ChecklistsRepository {

  final ChecklistRemoteSource _checklistsRemoteSource;

  ChecklistsRepositoryImpl(this._checklistsRemoteSource);

  @override
  Future<Result<List<CheckListInfoResponse>>> getLastCheckListInfo(GetLastChecklistParam param) async {
    return await _checklistsRemoteSource.getLastCheckListInfo(param);
  }



}

abstract class ChecklistsRepository {
  Future<Result<List<CheckListInfoResponse>>> getLastCheckListInfo(GetLastChecklistParam param);
}