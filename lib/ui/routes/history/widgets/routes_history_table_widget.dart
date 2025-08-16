import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'route_status_helper.dart';

class RoutesHistoryTableWidget extends StatelessWidget {
  final List<RouteResponse> routes;
  final List<UserResponse> users;
  final UserResponse? selectedUser;
  final DateTime? selectedDate;
  final String? selectedStatus;
  final RouteResponse? selectedRoute;
  final Function(UserResponse?) onUserChanged;
  final Function(DateTime?) onDateChanged;
  final Function(String?) onStatusChanged;
  final Function(RouteResponse) onRouteSelected;

  const RoutesHistoryTableWidget({
    super.key,
    required this.routes,
    required this.users,
    required this.selectedUser,
    required this.selectedDate,
    required this.selectedStatus,
    required this.selectedRoute,
    required this.onUserChanged,
    required this.onDateChanged,
    required this.onStatusChanged,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AppTableWidget(
        dataColumns: [
          const DataColumn(label: Text('Выбор')),
          DataColumn(
            label: DropdownButton<UserResponse>(
              underline: Container(),
              value: selectedUser,
              items: [
                const DropdownMenuItem<UserResponse>(
                    value: null, child: Text('Все')),
                ...users.map((e) => e).toSet().map(
                      (name) => DropdownMenuItem<UserResponse>(
                        value: name,
                        child: Text(name.name),
                      ),
                    ),
              ],
              onChanged: onUserChanged,
              iconDisabledColor: selectedUser != null ? Colors.blue : null,
              iconEnabledColor: selectedUser != null ? Colors.blue : null,
              isDense: true,
              selectedItemBuilder: (BuildContext context) => List.generate(
                4,
                (index) => Text(
                  'Сотрудник',
                  style: TextStyle(
                      color: selectedUser != null ? Colors.blue : null),
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
                  onDateChanged(picked);
                }
              },
              child: Row(
                children: [
                  Text(
                    'Дата старта',
                    style: TextStyle(
                        color: selectedDate != null ? Colors.blue : null),
                  ),
                  if (selectedDate != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () => onDateChanged(null),
                        child: const Icon(Icons.close,
                            color: Colors.blue, size: 15),
                      ),
                    )
                  else
                    const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          const DataColumn(label: Text('Название маршрута')),
          DataColumn(
            label: DropdownButton<String>(
              underline: Container(),
              value: selectedStatus,
              items: const [
                DropdownMenuItem(value: null, child: Text('Все')),
                DropdownMenuItem(value: 'ASSIGNED', child: Text('Назначен')),
                DropdownMenuItem(value: 'STARTED', child: Text('В работе')),
                DropdownMenuItem(value: 'FINISHED', child: Text('Закончен')),
              ],
              onChanged: onStatusChanged,
              iconDisabledColor: selectedStatus != null ? Colors.blue : null,
              iconEnabledColor: selectedStatus != null ? Colors.blue : null,
              isDense: true,
              selectedItemBuilder: (BuildContext context) => List.generate(
                4,
                (index) => Text(
                  'Статус маршрута',
                  style: TextStyle(
                      color: selectedStatus != null ? Colors.blue : null),
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
                      onChanged: (value) => onRouteSelected(route),
                    ),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text((route.engineer?.name).toString()),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child:
                        Text(DateFormat('dd.MM.yyyy').format(route.routeDate)),
                  )),
                  DataCell(
                    Text(
                      "${DateFormat('dd.MM.yy').format(route.routeDate)} - ${route.engineer?.name ?? 'Без исполнителя'}",
                    ),
                  ),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                        RouteStatusHelper.renderRouteStatus(route.routeStatus)),
                  )),
                  DataCell(
                    Align(
                      alignment: Alignment.center,
                      child: Text(RouteStatusHelper.pluralizePoints(
                          route.tasks.length)),
                    ),
                  ),
                ],
                selected: route == selectedRoute,
                onSelectChanged: (_) => onRouteSelected(route),
              ),
            )
            .toList(),
      ),
    );
  }
}
