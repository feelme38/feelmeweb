import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RouteFiltersWidget extends StatelessWidget {
  final UserResponse? selectedUser;
  final List<UserResponse> users;
  final DateTime? selectedDate;
  final String? selectedStatus;
  final Function(UserResponse?) onUserChanged;
  final Function(DateTime?) onDateChanged;
  final Function(String?) onStatusChanged;

  const RouteFiltersWidget({
    super.key,
    required this.selectedUser,
    required this.users,
    required this.selectedDate,
    required this.selectedStatus,
    required this.onUserChanged,
    required this.onDateChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // User filter
        Expanded(
          child: DropdownButton<UserResponse>(
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
            iconDisabledColor: selectedUser != null ? AppColor.primary : null,
            iconEnabledColor: selectedUser != null ? AppColor.primary : null,
            isDense: true,
            selectedItemBuilder: (BuildContext context) => List.generate(
              4,
              (index) => Text(
                'Сотрудник',
                style: TextStyle(
                    color: selectedUser != null ? AppColor.primary : null),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Date filter
        Expanded(
          child: GestureDetector(
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
                      color: selectedDate != null ? AppColor.primary : null),
                ),
                if (selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: () => onDateChanged(null),
                      child: const Icon(Icons.close,
                          color: AppColor.primary, size: 15),
                    ),
                  )
                else
                  const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Status filter
        Expanded(
          child: DropdownButton<String>(
            underline: Container(),
            value: selectedStatus,
            items: const [
              DropdownMenuItem(value: null, child: Text('Все')),
              DropdownMenuItem(
                  value: 'ASSIGNED', child: Text('Назначен')),
              DropdownMenuItem(
                  value: 'STARTED', child: Text('В работе')),
              DropdownMenuItem(
                  value: 'FINISHED', child: Text('Закончен')),
            ],
            onChanged: onStatusChanged,
            iconDisabledColor: selectedStatus != null ? AppColor.primary : null,
            iconEnabledColor: selectedStatus != null ? AppColor.primary : null,
            isDense: true,
            selectedItemBuilder: (BuildContext context) => List.generate(
              4,
              (index) => Text(
                'Статус маршрута',
                style: TextStyle(
                    color: selectedStatus != null ? AppColor.primary : null),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
