import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/ui/routes/history/widgets/info_row.dart';
import 'package:flutter/material.dart';

class RouteInfo extends StatelessWidget {
  final RouteResponse selectedRoute;

  const RouteInfo({super.key, required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    final tasks = selectedRoute.tasks;

    // Считаем количество по статусам
    final assignedCount =
        tasks.where((task) => task.taskStatus == "ASSIGNED").length;
    final completedCount =
        tasks.where((task) => task.taskStatus == "COMPLETED").length;

    return Column(
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
        InfoRow(
          title: "Сотрудник",
          value: selectedRoute.engineer?.name ?? "Исполнитель не назначен",
        ),
        InfoRow(
          title: "Статус маршрута",
          value: _renderRouteStatus(selectedRoute.routeStatus),
        ),
        InfoRow(
          title: "Задачи",
          value: "Назначено: $assignedCount | Выполнено: $completedCount",
        ),
        InfoRow(
            title: "Адреса",
            value: _pluralizePoints(tasks.length),
            onTap: () => _showTasksModal(context, tasks)),
        InfoRow(
          title: "Время задания",
          value:
              "${DateFormat('dd.MM.yyyy HH:mm').format(selectedRoute.routeDate)} - "
              "${DateFormat('dd.MM.yyyy 23:59').format(selectedRoute.routeDate)}",
        ),
        const InfoRow(title: "Прибытие", value: "-"),
        const InfoRow(title: "Теги", value: "-"),
        const InfoRow(title: "Статус изменен", value: "-"),
      ],
    );
  }

  /// Модалка со списком адресов
  void _showTasksModal(BuildContext context, List<Task> tasks) {
    Dialogs.showBaseDialog(
        context,
        Material(
          color: Colors.transparent, // чтобы фон был как в диалоге
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Список адресов",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.address.address), // строка адреса
                      subtitle: Text(
                          "Статус: ${_renderRouteStatus(task.taskStatus)}"),
                      onTap: () {
                        Navigator.of(context).pop(task.address);
                        debugPrint("Выбран адрес: ${task.address.address}");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        width: context.currentSize.width * 0.4);
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

  String _pluralizePoints(int count) {
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
