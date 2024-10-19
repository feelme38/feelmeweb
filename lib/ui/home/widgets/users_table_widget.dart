import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:flutter/material.dart';

class UsersTableWidget extends StatelessWidget {
  final List<UserResponse> users;

  const UsersTableWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('')),
          DataColumn(label: Text('Имя')),
          DataColumn(label: Text('Всего заданий')),
          DataColumn(label: Text('Выполнено заданий')),
          DataColumn(label: Text('Статус маршрута')),
          DataColumn(label: Text('')),
        ],
        rows: users.map((user) {
          return DataRow(cells: [
            // DataCell(CircleAvatar(
            //   backgroundImage: NetworkImage(user.avatarUrl),
            // )),
            DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Text(user.name),
                )
            ),
            DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Text(user.name),
                )
            ),
            DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Text(user.name),
                )
            ),
            DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Text(user.name),
                )
            ),
            DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Text(user.name),
                )
            ),
            // DataCell(Text(user.totalTasks.toString())),
            // DataCell(Text(user.completedTasks.toString())),
            // DataCell(Text(user.routeStatus)),
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
        }).toList(),
      ),
    );
  }
}