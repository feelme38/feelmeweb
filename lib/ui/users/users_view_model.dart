import 'package:base_class_gen/core/ext/string_ext.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class UsersViewModel extends BaseSearchViewModel {

  UsersViewModel() {
    loadUsers();
  }

  final _getUsersUseCase = GetUsersUseCase();

  List<UserResponse> _users = [];
  List<UserResponse> get users => _users;

  final List<DataColumn> _tableUsersColumns = [
    const DataColumn(label: Text('')),
    const DataColumn(label: Text('Имя')),
    const DataColumn(label: Text('Всего заданий')),
    const DataColumn(label: Text('Выполнено заданий')),
    const DataColumn(label: Text('Статус маршрута')),
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

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  String _renderRouteStatus(String? routeStatus) {
    switch(routeStatus) {
      case 'ASSIGNED': return 'Назначен';
      case 'STARTED': return 'В работе';
      case 'PAUSED': return 'Перерыв';
      case 'FINISHED': return 'Закончен';
      default: return 'Без маршрута';
    }
  }

  List<DataRow> getTableUsersRows(List<UserResponse> users) => users.map((user) {
    return DataRow(cells: [
      DataCell(CircleAvatar(
        backgroundImage: NetworkImage(
            user.profileUrl.orEmpty
        ),
      )),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(user.name),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(user.allTasksCount.toString()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(user.completedTasksCount.toString()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(_renderRouteStatus(user.routeStatus?.name)),
          )
      ),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.directions),
            onPressed: () {
              // Логика назначения маршрута
            },
            tooltip: 'Создать маршрут',
          ),
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

  @override
  String get title => 'Сервисные инженеры';
}