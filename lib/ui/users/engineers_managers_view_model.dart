import 'package:flutter/material.dart';

import '../../data/models/response/roles_response.dart';
import '../../data/models/response/user_response.dart';
import '../../data/repository/users/users_repository.dart';
import '../../domain/users/delete_user_usecase.dart';
import '../../domain/users/get_roles_usecase.dart';
import '../../domain/users/get_users_usecase.dart';
import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_search_view_model.dart';
import '../../provider/di/di_provider.dart';

class EngineersManagersViewModel extends BaseSearchViewModel {
  EngineersManagersViewModel() {
    _getRolesUseCase().then((_) {
      selectedRole = getIt<UsersRepository>().roles.first;
      loadUsers();
    });
  }

  final _deleteUserUseCase = DeleteUserUseCase();
  final _getUsersUseCase = GetUsersUseCase();
  final _getRolesUseCase = GetRolesUseCase();

  RolesResponse? selectedRole;
  List<UserResponse> _users = [];
  List<UserResponse> _filteredUsers = [];

  List<UserResponse> get users => _filteredUsers;
  List<RolesResponse> get roles => getIt<UsersRepository>().roles;

  @override
  String get title => 'Инженеры и менеджеры';

  List<DataColumn> get tableUsersColumns => const [
        DataColumn(label: Text('Имя')),
        DataColumn(label: Text('')),
      ];

  List<DataRow> getTableUsersRows(List<UserResponse> users) =>
      users.map((user) {
        return DataRow(cells: [
          DataCell(Align(
              alignment: Alignment.center, child: Text(user.name))),
          DataCell(Row(children: [
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteUser(user.id),
                tooltip: 'Удалить'),
          ])),
        ]);
      }).toList();

  void deleteUser(String userId) async {
    loadingOn();
    (await executeUseCaseParam<bool, String>(_deleteUserUseCase, userId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((_) {
      addAlert(Alert('Пользователь успешно удален', style: AlertStyle.success));
      loadUsers();
    });
    loadingOff();
  }

  void updateSelectedRole(String? id) {
    selectedRole = roles.firstWhere((element) => element.id == id);
    notifyListeners();
    loadUsers();
  }

  void loadUsers() async {
    loadingOn();
    (await executeUseCaseParam<List<UserResponse>, String?>(
            _getUsersUseCase, selectedRole?.id))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      _filteredUsers = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    if (text == null || text.isEmpty) {
      _filteredUsers = _users;
    } else {
      _filteredUsers = _users
          .where((user) => user.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}


