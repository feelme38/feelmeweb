import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_view_model.dart';

class AromasViewModel extends BaseViewModel {

  AromasViewModel() {
    loadUsers();
  }

  final _getUsersUseCase = GetUsersUseCase();

  List<UserResponse> _users = [];
  List<UserResponse> get users => _users;

  final List<DataColumn> _tableUsersColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('')),
  ];
  List<DataColumn> get tableUsersColumns => _tableUsersColumns;

  void loadUsers() async {
    loadingOn();
    (await executeUseCaseParam<List<UserResponse>, String?>(_getUsersUseCase, 'd73285b5-dd1a-43a4-8c04-4cb65f62af3a'))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      notifyListeners();
    });
    loadingOff();
  }

  List<DataRow> getTableUsersRows(List<UserResponse> users) => users.map((user) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(user.name),
          )
      ),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Логика редактирования пользователя
            },
            tooltip: 'Редактировать',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Логика удаления пользователя
            },
            tooltip: 'Удалить',
          ),
        ],
      )),
    ]);
  }).toList();
}