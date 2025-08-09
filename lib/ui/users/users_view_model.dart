import 'package:feelmeweb/data/models/response/roles_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/users/get_roles_usecase.dart';
import '../../presentation/alert/alert.dart';
import '../../presentation/navigation/route_generation.dart';
import '../../provider/di/di_provider.dart';

class UsersViewModel extends BaseSearchViewModel {
  UsersViewModel() {
    _getRolesUseCase().then((_) {
      selectedRole = getIt<UsersRepository>().roles.first;
      loadUsers();
    });
  }

  RolesResponse? selectedRole;

  List<RolesResponse> get roles => getIt<UsersRepository>().roles;
  final _getUsersUseCase = GetUsersUseCase();
  final _getRolesUseCase = GetRolesUseCase();
  List<UserResponse> _users = [];
  List<UserResponse> _filteredUsers = [];

  List<UserResponse> get users => _filteredUsers;

  void updateSelectedRole(String? id) {
    selectedRole = roles.firstWhere((element) => element.id == id);
    notifyListeners();
    loadUsers();
  }

  final List<DataColumn> _tableUsersColumns = [
    const DataColumn(label: Text('Имя')),
    const DataColumn(label: Text('Всего заданий')),
    const DataColumn(label: Text('Выполнено заданий')),
    const DataColumn(label: Text('Статус маршрута')),
    const DataColumn(label: Text('')),
  ];

  List<DataColumn> get tableUsersColumns => _tableUsersColumns;

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

  @protected
  String renderRouteStatus(String? routeStatus) {
    switch (routeStatus) {
      case 'ASSIGNED':
        return 'Назначен';
      case 'STARTED':
        return 'В работе';
      case 'PAUSED':
        return 'Перерыв';
      case 'FINISHED':
        return 'Закончен';
      default:
        return 'Без маршрута';
    }
  }
  @protected
  BuildContext? get navigatorContext =>
      getIt<RouteGenerator>().navigatorKey.currentContext;

  @protected
  void onOpenRouteInfo(BuildContext context, String userId) {
    context.go(RouteName.routeInfo, extra: userId);
  }

  List<DataRow> getTableUsersRows(List<UserResponse> users) =>
      users.map((user) {
        final routeAvailable = ![
          RouteStatus.CANCELED,
          RouteStatus.FINISHED,
          null
        ].contains(user.routeStatus);
        return DataRow(cells: [
          DataCell(Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    if (routeAvailable) {
                      final context =
                          getIt<RouteGenerator>().navigatorKey.currentContext;
                      if (context == null) return;
                      context.go(RouteName.routeInfo, extra: user.id);
                    }
                  },
                  child: Text(user.name)))),
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
                icon: const Icon(Icons.directions),
                onPressed: () {
                  final context =
                      getIt<RouteGenerator>().navigatorKey.currentContext;
                  if (context == null) return;
                  context.go(
                    RouteName.customerCreateRoute,
                    extra: {'userId': user.id},
                  );
                },
                tooltip: 'Создать маршрут'),
            if (![RouteStatus.CANCELED, RouteStatus.FINISHED, null]
                .contains(user.routeStatus))
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  final context =
                      getIt<RouteGenerator>().navigatorKey.currentContext;
                  if (context == null) return;
                  context.go(RouteName.customerEditRoute, extra: user.id);
                },
                tooltip: 'Редактировать',
              ),
          ])),
        ]);
      }).toList();

  @override
  String get title => 'Сервисные инженеры';
}
