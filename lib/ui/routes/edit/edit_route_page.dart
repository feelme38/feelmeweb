import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/presentation/base_screen/base_screen.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/search_widget.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/routes/create/widgets/time_input_field.dart';
import 'package:feelmeweb/ui/routes/edit/widgets/edit_subtasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'edit_route_view_model.dart';

class EditRoutePage extends StatelessWidget {
  const EditRoutePage({super.key});

  static Widget create(String userId) => ChangeNotifierProvider(
        create: (context) => EditRouteViewModel(userId),
        child: const EditRoutePage(),
      );

  @override
  Widget build(BuildContext context) {
    final route = context.watch<EditRouteViewModel>().route;
    final hasChanges = context.watch<EditRouteViewModel>().hasChanges;
    final viewModel = context.read<EditRouteViewModel>();
    final filteredTasks = route?.tasks
        .where((e) =>
            !['CANCELED', 'COMPLETED'].contains(e.taskStatus) &&
            e.subtasks.isNotEmpty)
        .toList();
    return BaseScreen<EditRouteViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context),
      appBar: SearchWidget<EditRouteViewModel>(
          context.read<EditRouteViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Column(
        children: [
          if (route != null)
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final task = filteredTasks![index];
                    final timeController =
                        viewModel.timeControllers.putIfAbsent(
                      '${task.client.id}_${task.address.id}',
                      () => TextEditingController(
                        text: DateFormat('HH:mm').format(task.visitDateTime!),
                      ),
                    );
                    final lastDate = viewModel.getLastVisitDate(
                      task.client.id,
                      task.address.id,
                    );

                    return ExpansionTile(
                      shape: const Border(),
                      collapsedShape: const Border(),
                      leading: const Icon(Icons.expand_more),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete, color: AppColor.redDefect),
                        onPressed: () => viewModel.onDeleteTask(task.id),
                        tooltip: 'Удалить',
                      ),
                      expandedAlignment: Alignment.center,
                      expandedCrossAxisAlignment: CrossAxisAlignment.center,
                      title: Column(
                        children: [
                          Text(task.name, textAlign: TextAlign.center),
                          Text(task.address.address,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Время посещения:"),
                              const SizedBox(width: 8),
                              TimeInputField(
                                controller: timeController,
                                onChanged: (_) =>
                                    viewModel.updateVisitTimeForAddress(
                                        task.client.id,
                                        task.address.id,
                                        timeController.text),
                              ),
                              const SizedBox(width: 16),
                              Text("Дата последнего посещения: $lastDate"),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        EditSubtasksWidget(task: task),
                      ],
                    );
                  },
                  itemCount: filteredTasks?.length ?? 0),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200,
                    child: BaseTextButton(
                        buttonText: "Снять с маршрута",
                        onTap: () => viewModel.onRemoveFromRoute(),
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: true,
                        textColor: Colors.white,
                        buttonColor: AppColor.redDefect),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        child: BaseTextButton(
                            buttonText: "Применить изменения",
                            onTap: viewModel.updateRoute,
                            weight: FontWeight.w500,
                            fontSize: 14,
                            enabled: hasChanges,
                            textColor: Colors.white,
                            buttonColor: AppColor.success),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 200,
                        child: BaseTextButton(
                            buttonText: "Добавить маршрут",
                            onTap: () => context.go(
                                  RouteName.customerCreateRoute,
                                  extra: {
                                    'userId': viewModel.userId,
                                    'isUpdate': true
                                  },
                                ),
                            weight: FontWeight.w500,
                            fontSize: 14,
                            enabled: true,
                            textColor: Colors.white,
                            buttonColor: AppColor.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
