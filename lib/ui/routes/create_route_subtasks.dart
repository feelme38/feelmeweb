import 'package:feelmeweb/core/extensions/base_class_extensions/list_ext.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/ui/routes/widgets/choose_subtasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/buttons/base_text_button.dart';
import '../../presentation/theme/theme_colors.dart';
import 'create_route_view_model.dart';

class CreateRouteSubtasksWidget extends StatelessWidget {
  const CreateRouteSubtasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>();
    final selectedCustomers =
        context.watch<CreateRouteViewModel>().selectedCustomers;
    final checklists = context.watch<CreateRouteViewModel>().lastChecklists;
    final checklistsNotNullId =
        checklists.where((item) => item.id != null).toList();
    final lastDate = checklistsNotNullId.isEmpty
        ? " – "
        : checklistsNotNullId.firstOrNull?.createdAt?.toDateTime()?.orDash();
    final selectedCustomer =
        context.watch<CreateRouteViewModel>().selectedCustomer;
    final aromas = context.watch<CreateRouteViewModel>().aromas;
    final taskTypes = context.watch<CreateRouteViewModel>().taskTypes;
    var selectedTaskType =
        context.watch<CreateRouteViewModel>().selectedTaskType;
    final selectedSubtasks =
        context.watch<CreateRouteViewModel>().selectedSubtasks;
    final savedTasks = context.watch<CreateRouteViewModel>().savedTasks;

    return Builder(builder: (context) {
      if (selectedCustomer == null) return const SizedBox();
      return Row(children: [
        Expanded(
            child: ListView.builder(
                itemCount: selectedCustomers.length,
                itemBuilder: (context, index) {
                  final customer = selectedCustomers[index];
                  final customerWidgets = addressUI(customer, viewModel);
                  return Column(children: customerWidgets);
                })),
        Expanded(
            flex: 4,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Юр. лицо: ${selectedCustomer.name}"),
                                          Text(
                                              "ЛПР: ${selectedCustomer.ownerName}"),
                                          Text(
                                              "Телефон: ${selectedCustomer.phone}")
                                        ])),
                                const Spacer(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Дата последнего посещения: $lastDate"),
                                      Row(children: [
                                        const Text("Тип задания:"),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16.0, 0, 8.0, 0),
                                            child: DropdownButton(
                                                value: selectedTaskType,
                                                onChanged: (newValue) {
                                                  viewModel.selectNewTaskType(
                                                      newValue);
                                                },
                                                items: taskTypes.map((e) {
                                                  return DropdownMenuItem(
                                                      value: e,
                                                      child: SizedBox(
                                                          width: 150,
                                                          child: Text(e.name)));
                                                }).toList(),
                                                focusColor: Colors.white,
                                                dropdownColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)))
                                      ])
                                    ])
                              ]))),
                  Expanded(
                      flex: 1,
                      child: Builder(builder: (context) {
                        return CreateRouteChooseSubtasksWidget(
                            customerId: selectedCustomer.id ?? '',
                            checklists: checklists,
                            selectedSubtasks: selectedSubtasks,
                            aromas: aromas,
                            toggleCallback: (subtask) {
                              viewModel.toggleSubtaskSelection(subtask);
                            });
                      })),
                  Row(children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32),
                        child: SizedBox(
                            width: 200,
                            child: BaseTextButton(
                                buttonText: "Создать маршрут",
                                onTap: () => viewModel.createRoute(),
                                weight: FontWeight.w500,
                                fontSize: 14,
                                enabled:
                                    savedTasks.containsKey(selectedCustomer.id),
                                textColor: Colors.white,
                                buttonColor: AppColor.redDefect))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0.0, 0.0, 32),
                      child: BaseTextButton(
                          buttonText: "Добавить оборудование",
                          onTap: () {

                          },
                          weight: FontWeight.w500,
                          fontSize: 14,
                          enabled: savedTasks.containsKey(selectedCustomer.id),
                          textColor: Colors.white,
                          buttonColor: AppColor.redDefect),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 18, 32),
                        child: SizedBox(
                            width: 150,
                            child: BaseTextButton(
                                buttonText: "Назад",
                                onTap: () => viewModel.resetStage(),
                                weight: FontWeight.w500,
                                fontSize: 14,
                                enabled: true,
                                textColor: Colors.white,
                                buttonColor: AppColor.primary))),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
                        child: SizedBox(
                            width: 200,
                            child: BaseTextButton(
                                buttonText: "Сохранить задание",
                                onTap: () {
                                  viewModel.addTask();
                                },
                                weight: FontWeight.w500,
                                fontSize: 14,
                                enabled: selectedSubtasks
                                    .filter((e) =>
                                        e.customerId == selectedCustomer.id)
                                    .isNotEmpty,
                                textColor: Colors.white,
                                buttonColor: AppColor.primary)))
                  ])
                ]))
      ]);
    });
  }

  List<Widget> addressUI(
      CustomerResponse customer, CreateRouteViewModel viewModel) {
    final addresses = customer.addresses ?? [];
    final name = customer.name ?? '';

    return addresses.map((e) {
      final isSelectedAddress = viewModel.selectedAddressId == e.id;
      return Container(
        decoration: BoxDecoration(
            color: isSelectedAddress ? Colors.blue[100] : Colors.transparent),
        child: ListTile(
            title: Column(children: [
              Text(name, style: const TextStyle(fontSize: 18)),
              Text(e.address ?? '', style: const TextStyle(fontSize: 12))
            ]),
            tileColor:
                isSelectedAddress ? Colors.blue[100] : Colors.transparent,
            onTap: () {
              viewModel.loadLastChecklistsInfo(
                  customer: customer, addressId: e.id);
            }),
      );
    }).toList();
  }
}
