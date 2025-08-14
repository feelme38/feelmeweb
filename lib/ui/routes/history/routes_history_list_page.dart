import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../presentation/base_screen/base_screen.dart';
import '../../../presentation/widgets/search_widget.dart';
import '../../common/app_table_widget.dart';
import 'routes_history_list_view_model.dart';

class RoutesHistoryListPage extends StatelessWidget {
  const RoutesHistoryListPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => RoutesHistoryViewModel(),
      child: const RoutesHistoryListPage());

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RoutesHistoryViewModel>();

    final paginationRoutes =
        context.watch<RoutesHistoryViewModel>().paginationRoutes;
    final routes = context.watch<RoutesHistoryViewModel>().routes;

    final users = context.watch<RoutesHistoryViewModel>().users;

    final selectedStatus =
        context.watch<RoutesHistoryViewModel>().selectedStatus;
    final selectedDate = context.watch<RoutesHistoryViewModel>().selectedDate;
    final selectedUser = context.watch<RoutesHistoryViewModel>().selectedUser;
    final selectedRoute = context.watch<RoutesHistoryViewModel>().selectedRoute;

    final currentPage = context.watch<RoutesHistoryViewModel>().currentPage;
    int lastPage = paginationRoutes?.meta.totalPages ?? 1;

    return BaseScreen<RoutesHistoryViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<RoutesHistoryViewModel>(viewModel.onSearch, () {},
            needBottomEdge: true, needBackButton: false),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: AppTableWidget(
                            dataColumns: [
                              const DataColumn(
                                label: Text('Выбор'),
                              ),
                              DataColumn(
                                label: DropdownButton<UserResponse>(
                                  underline: Container(),
                                  value: selectedUser,
                                  items: [
                                    const DropdownMenuItem<UserResponse>(
                                        value: null, child: Text('Все')),
                                    ...users.map((e) => e).toSet().map(
                                          (name) =>
                                              DropdownMenuItem<UserResponse>(
                                            value: name,
                                            child: Text(name.name),
                                          ),
                                        ),
                                  ],
                                  onChanged: (val) {
                                    viewModel.filterByUser(val);
                                  },
                                  iconDisabledColor: selectedUser != null
                                      ? AppColor.primary
                                      : null,
                                  iconEnabledColor: selectedUser != null
                                      ? AppColor.primary
                                      : null,
                                  isDense: true,
                                  selectedItemBuilder: (BuildContext context) =>
                                      List.generate(
                                    4,
                                    (index) => Text(
                                      'Сотрудник',
                                      style: TextStyle(
                                          color: selectedUser != null
                                              ? AppColor.primary
                                              : null),
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: GestureDetector(
                                  onTap: () async {
                                    final now = DateTime.now();
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: DateTime(now.year - 1),
                                      lastDate: DateTime(now.year + 2),
                                      locale: const Locale('ru'),
                                    );
                                    if (picked != null) {
                                      viewModel.filterByDate(picked);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text('Дата старта',
                                          style: TextStyle(
                                              color: selectedDate != null
                                                  ? AppColor.primary
                                                  : null)),
                                      if (selectedDate != null)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: GestureDetector(
                                            onTap: () =>
                                                viewModel.filterByDate(null),
                                            child: const Icon(Icons.close,
                                                color: AppColor.primary,
                                                size: 15),
                                          ),
                                        )
                                      else
                                        const Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                ),
                              ),
                              const DataColumn(
                                  label: Text(
                                      'Название маршрута')), // ✅ новая колонка
                              DataColumn(
                                label: DropdownButton<String>(
                                  underline: Container(),
                                  value: selectedStatus,
                                  items: const [
                                    DropdownMenuItem(
                                        value: null, child: Text('Все')),
                                    DropdownMenuItem(
                                        value: 'ASSIGNED',
                                        child: Text('Назначен')),
                                    DropdownMenuItem(
                                        value: 'STARTED',
                                        child: Text('В работе')),
                                    DropdownMenuItem(
                                        value: 'FINISHED',
                                        child: Text('Закончен')),
                                  ],
                                  onChanged: (val) {
                                    viewModel.filterByStatus(val);
                                  },
                                  iconDisabledColor: selectedStatus != null
                                      ? AppColor.primary
                                      : null,
                                  iconEnabledColor: selectedStatus != null
                                      ? AppColor.primary
                                      : null,
                                  isDense: true,
                                  selectedItemBuilder: (BuildContext context) =>
                                      List.generate(
                                    4,
                                    (index) => Text(
                                      'Статус маршрута',
                                      style: TextStyle(
                                          color: selectedStatus != null
                                              ? AppColor.primary
                                              : null),
                                    ),
                                  ),
                                ),
                              ),
                              const DataColumn(label: Text('Адреса')),
                            ],
                            dataRows: routes
                                .map(
                                  (route) => DataRow(
                                    cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            value: route == selectedRoute,
                                            onChanged: (value) =>
                                                viewModel.selectRoute(route),
                                          ))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text((route.engineer?.name)
                                              .toString()))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(DateFormat('dd.MM.yyyy')
                                              .format(route.routeDate)))),
                                      DataCell(
                                        // ✅ название маршрута
                                        Text(
                                          "${DateFormat('dd.MM.yy').format(route.routeDate)} - ${route.engineer?.name ?? 'Без исполнителя'}",
                                        ),
                                      ),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(_renderRouteStatus(
                                              route.routeStatus)))),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(pluralizePoints(
                                              route.tasks.length)),
                                        ),
                                      ),
                                    ],
                                    selected: route == selectedRoute,
                                    onSelectChanged: (_) {
                                      viewModel.selectRoute(route);
                                    },
                                  ),
                                )
                                .toList(),
                          )),
                    ),
                  ),
                  // ПРАВАЯ ЧАСТЬ — детали маршрута
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: selectedRoute == null
                          ? const Center(child: Text("Маршрут не выбран"))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Информация о задании",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _infoRow(
                                  "Сотрудник",
                                  selectedRoute.engineer?.name ??
                                      "Исполнитель не назначен",
                                ),
                                _infoRow(
                                  "Статус задания",
                                  _renderRouteStatus(selectedRoute.routeStatus),
                                ),
                                _infoRow(
                                  "Название",
                                  "${DateFormat('dd.MM.yy').format(selectedRoute.routeDate)} - ${selectedRoute.engineer?.name ?? ''}",
                                ),
                                _infoRow(
                                  "Адрес",
                                  pluralizePoints(selectedRoute.tasks.length),
                                ),
                                _infoRow(
                                  "Время задания",
                                  "${DateFormat('dd.MM.yyyy HH:mm').format(selectedRoute.routeDate)} - ${DateFormat('dd.MM.yyyy 23:59').format(selectedRoute.routeDate)}",
                                ),
                                _infoRow("Прибытие", "-"),
                                _infoRow("Теги", "-"),
                                _infoRow("Статус изменен", "-"),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 32),
                    child: SizedBox(
                        width: 200,
                        child: BaseTextButton(
                            buttonText: "Копировать маршрут",
                            onTap: () {
                              final engineerId = selectedRoute?.engineer?.id;
                              final routeDate = selectedRoute?.routeDate;
                              if (engineerId == null && routeDate != null) {
                                return;
                              }

                              context.go(
                                RouteName.customerCopyRoute,
                                extra: {
                                  'userId': engineerId,
                                  'routeDate': routeDate
                                },
                              );
                            },
                            weight: FontWeight.w500,
                            fontSize: 14,
                            enabled: selectedRoute != null,
                            textColor: Colors.white,
                            buttonColor: AppColor.success))),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: BaseTextButton(
                              buttonText: "<",
                              onTap: () =>
                                  viewModel.changePage(currentPage - 1),
                              weight: FontWeight.w500,
                              fontSize: 14,
                              enabled: currentPage > 1,
                              textColor: Colors.white,
                              buttonColor: AppColor.primary)),
                      const SizedBox(width: 10),
                      Text('$currentPage / $lastPage'),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 50,
                          child: BaseTextButton(
                              buttonText: ">",
                              onTap: () =>
                                  viewModel.changePage(currentPage + 1),
                              weight: FontWeight.w500,
                              fontSize: 14,
                              enabled: currentPage < lastPage,
                              textColor: Colors.white,
                              buttonColor: AppColor.primary)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
                    child: SizedBox(
                        width: 200,
                        child: BaseTextButton(
                            buttonText: "Создать маршрут",
                            onTap: () {
                              final engineerId = selectedRoute?.engineer?.id;
                              if (engineerId == null) return;

                              final context = getIt<RouteGenerator>()
                                  .navigatorKey
                                  .currentContext;
                              if (context == null) return;

                              context.go(
                                RouteName.customerCreateRoute,
                                extra: {'userId': engineerId},
                              );
                            },
                            weight: FontWeight.w500,
                            fontSize: 14,
                            enabled: selectedRoute != null,
                            textColor: Colors.white,
                            buttonColor: AppColor.redDefect))),
              ],
            )
          ],
        ));
  }

  // Хелпер для строки
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _renderRouteStatus(String? routeStatus) {
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

  String pluralizePoints(int count) {
    final lastTwoDigits = count % 100;
    final lastDigit = count % 10;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
      return '$count точек в маршруте';
    }

    switch (lastDigit) {
      case 1:
        return '$count точка в маршруте';
      case 2:
      case 3:
      case 4:
        return '$count точки в маршруте';
      default:
        return '$count точек в маршруте';
    }
  }
}
