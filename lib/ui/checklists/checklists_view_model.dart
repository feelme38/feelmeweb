import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/checklists/get_checklists_usecase.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../presentation/alert/alert.dart';

class ChecklistsViewModel extends BaseSearchViewModel {
  ChecklistsViewModel() {
    loadUsers();
  }

  final _getUsersUseCase = GetUsersUseCase();
  final _getChecklistsUseCase = GetChecklistsUseCase();

  List<UserResponse> _users = [];

  List<UserResponse> get users => _users;

  List<CheckListInfoResponse> _checklists = [];
  List<CheckListInfoResponse> _filteredChecklists = [];

  List<CheckListInfoResponse> get checklists => _filteredChecklists;

  late String selectedUserId;

  void chooseDefaultUser() {
    if (_users.isNotEmpty) {
      selectedUserId = _users.first.id;
      loadChecklists(userId: selectedUserId);
    }
  }

  void loadUsers() async {
    loadingOn();
    (await executeUseCaseParam<List<UserResponse>, String?>(
            _getUsersUseCase, 'd73285b5-dd1a-43a4-8c04-4cb65f62af3a'))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      chooseDefaultUser();
      notifyListeners();
    });
    loadingOff();
  }

  void loadChecklists({required String userId}) async {
    selectedUserId = userId;
    loadingOn();
    (await executeUseCaseParam<List<CheckListInfoResponse>, GetChecklistParam>(
            _getChecklistsUseCase, GetChecklistParam(userId)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _checklists = value;
      _filteredChecklists = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    if (text == null || text.isEmpty) {
      _filteredChecklists = _checklists;
    } else {
      _filteredChecklists = _checklists
          .where((checklist) =>
              checklist.customer?.name
                  ?.toLowerCase()
                  .contains(text.toLowerCase()) ??
              false)
          .toList();
    }
    notifyListeners();
  }

  @override
  String get title => 'Чек-листы';
}
