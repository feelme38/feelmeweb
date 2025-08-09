import 'package:flutter/material.dart';

import '../../data/models/response/user_response.dart';
import '../../domain/users/delete_user_usecase.dart';
import '../../presentation/alert/alert.dart';
import 'users_view_model.dart';

class EngineersManagersViewModel extends UsersViewModel {
  final _deleteUserUseCase = DeleteUserUseCase();

  @override
  String get title => 'Инженеры и менеджеры';

  @override
  List<DataRow> getTableUsersRows(List<UserResponse> users) =>
      users.map((user) {
        return DataRow(cells: [
          DataCell(Align(
              alignment: Alignment.center,
              child: Text(user.name))),
          DataCell(Align(
              alignment: Alignment.center,
              child: Text(user.allTasksCount.toString()))),
          DataCell(Align(
              alignment: Alignment.center,
              child: Text(user.completedTasksCount.toString()))),
          DataCell(Align(
              alignment: Alignment.center,
              child: Text(renderRouteStatus(user.routeStatus?.name)))),
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
}


