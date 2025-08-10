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

import '../../../core/date_utils.dart';
import 'edit_route_view_model.dart';

class EditRoutePage extends StatefulWidget {
  const EditRoutePage({super.key});

  static Widget create(String userId) => ChangeNotifierProvider(
        create: (context) => EditRouteViewModel(userId),
        child: const EditRoutePage(),
      );

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
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
          // Route date picker row (prefilled from backend if available)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(children: [
              const Text('Дата маршрута:'),
              const SizedBox(width: 12),
              SizedBox(
                width: 160,
                child: _RouteDateField(),
              ),
              const Spacer(),
            ]),
          ),
          if (route != null)
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final task = filteredTasks![index];
                    final fromController = viewModel.fromControllers.putIfAbsent(
                      '${task.client.id}_${task.address.id}',
                      () => TextEditingController(
                        text: task.visitFromTime != null
                            ? DateFormat('HH:mm').format(task.visitFromTime!)
                            : '',
                      ),
                    );
                    final toController = viewModel.toControllers.putIfAbsent(
                      '${task.client.id}_${task.address.id}',
                      () => TextEditingController(
                        text: task.visitToTime != null
                            ? DateFormat('HH:mm').format(task.visitToTime!)
                            : '',
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
                                controller: fromController,
                                onChanged: (v) {
                                  viewModel.updateVisitTimeFrom(
                                      task.client.id, task.address.id, v);
                                  final from = DateUtil.parseTime(v);
                                  final to = DateUtil.parseTime(toController.text);
                                  if (from != null && to != null && to.isBefore(from)) {
                                    toController.clear();
                                    setState(() {});
                                  } else {
                                    setState(() {});
                                  }
                                },
                                onTap: () async {
                                  final now = TimeOfDay.now();
                                  final t = await showTimePicker(
                                    context: context,
                                    initialTime: now,
                                    builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(alwaysUse24HourFormat: true),
                                      child: child ?? const SizedBox.shrink(),
                                    ),
                                  );
                                  if (t == null) return;
                                  String two(int v) => v.toString().padLeft(2, '0');
                                  fromController.text =
                                      '${two(t.hour)}:${two(t.minute)}';
                                  viewModel.updateVisitTimeFrom(task.client.id,
                                      task.address.id, fromController.text);
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 12),
                              const Text('—'),
                              const SizedBox(width: 12),
                              TimeInputField(
                                controller: toController,
                                hasError: () {
                                  final from = DateUtil.parseTime(fromController.text);
                                  final to = DateUtil.parseTime(toController.text);
                                  return from != null && to != null && to.isBefore(from);
                                }(),
                                onChanged: (v) {
                                  final from = DateUtil.parseTime(fromController.text);
                                  final to = DateUtil.parseTime(v);
                                  if (from != null && to != null && to.isBefore(from)) {
                                    toController.clear();
                                    setState(() {});
                                  } else {
                                    viewModel.updateVisitTimeTo(
                                        task.client.id, task.address.id, v);
                                    setState(() {});
                                  }
                                },
                                onTap: () async {
                                  final now = TimeOfDay.now();
                                  final t = await showTimePicker(
                                    context: context,
                                    initialTime: now,
                                    builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(alwaysUse24HourFormat: true),
                                      child: child ?? const SizedBox.shrink(),
                                    ),
                                  );
                                  if (t == null) return;
                                  String two(int v) => v.toString().padLeft(2, '0');
                                  final toStr = '${two(t.hour)}:${two(t.minute)}';
                                  final from = DateUtil.parseTime(fromController.text);
                                  final toDt = DateUtil.parseTime(toStr);
                                  if (from != null && toDt != null && toDt.isBefore(from)) {
                                    toController.clear();
                                    setState(() {});
                                  } else {
                                    toController.text = toStr;
                                    viewModel.updateVisitTimeTo(task.client.id,
                                        task.address.id, toController.text);
                                    setState(() {});
                                  }
                                },
                              ),
                              const SizedBox(width: 16),
                        Text("Дата последнего посещения: $lastDate"),
                            ],
                          ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        maxLength: 500,
                        decoration: const InputDecoration(
                          hintText: 'Комментарий к посещению',
                          counterText: '',
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        onChanged: (value) => viewModel.updateTaskComment(
                            task.client.id, task.address.id, value),
                      ),
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

class _RouteDateField extends StatefulWidget {
  @override
  State<_RouteDateField> createState() => _RouteDateFieldState();
}

class _RouteDateFieldState extends State<_RouteDateField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<EditRouteViewModel>();
      final route = vm.route;
      if (vm.selectedRouteDate != null) {
        _controller.text = vm.selectedRouteDate!;
      } else if (route != null) {
        _controller.text = route.routeDate;
        vm.selectedRouteDate = _controller.text;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _controller,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        hintText: 'ГГГГ-ММ-ДД',
        isDense: true,
        border: OutlineInputBorder(),
      ),
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
          _controller.text = DateFormat('yyyy-MM-dd').format(picked);
          context.read<EditRouteViewModel>().selectedRouteDate = _controller.text;
        }
      },
    );
  }
}
