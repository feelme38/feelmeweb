import 'package:base_class_gen/core/ext/string_ext.dart';
import 'package:feelmeweb/ui/routes/widgets/choose_subtasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/buttons/base_text_button.dart';
import '../../presentation/theme/theme_colors.dart';
import '../common/app_table_widget.dart';
import 'create_route_view_model.dart';

class CreateRouteSubtasksWidget extends StatelessWidget {

  const CreateRouteSubtasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>();
    final selectedCustomers = context.watch<CreateRouteViewModel>().selectedCustomers;
    final checklists = context.watch<CreateRouteViewModel>().lastChecklists;
    final lastDate = checklists.firstOrNull == null ? "" : checklists.firstOrNull?.createdAt.toDateTime();
    final selectedCustomer = context.watch<CreateRouteViewModel>().selectedCustomer;
    final aromas = context.watch<CreateRouteViewModel>().aromas;

    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: selectedCustomers.length,
            itemBuilder: (context, index) {
              final customer = selectedCustomers[index];
             final isSelectedCustomer = viewModel.selectedCustomerId == customer.id;
              return ListTile(
                title: Column(
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(
                          fontSize: 18
                      ),
                    ),
                    Text(
                        customer.address,
                        style: const TextStyle(
                          fontSize: 12
                        ),
                    ),
                  ],
                ),
                tileColor:
                isSelectedCustomer ? Colors.blue[100] : Colors.transparent,
                onTap: () {
                  viewModel.loadLastChecklistsInfo(customer: customer);
                },
              );
            },
          ),
        ),
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
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Юр. лицо: ${selectedCustomer?.name.orEmpty}"),
                              Text("ЛПР: ${selectedCustomer?.ownerName.orEmpty}"),
                              Text("Телефон: ${selectedCustomer?.phone.orEmpty}"),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text("Дата последнего посещения: $lastDate"),
                          Row(
                            children: [
                              const Text("Тип задания:"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                                child: DropdownButton(
                                  value: "Плановое",
                                  onChanged: (newValue) {

                                  },
                                  items: ["Плановое", "Неплановое"].map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(e),
                                      ),
                                    );
                                  }).toList(),
                                  focusColor: Colors.white,
                                  dropdownColor: Colors.white,
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ])
                      ],
                    ),
                  ),
              ),
              Expanded(
                flex: 1,
                child: CreateRouteChooseSubtasksWidget(
                  checklists: checklists,
                  selectedChecklists: const [],
                  aromas: aromas,
                  toggleCallback: (checklist) {

                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32),
                    child: SizedBox(
                      width: 200,
                      child: BaseTextButton(
                          buttonText: "Создать маршрут",
                          onTap: () => viewModel.resetStage(),
                          weight: FontWeight.w500,
                          fontSize: 14,
                          enabled: true,//selectedCustomers.isNotEmpty,
                          textColor: Colors.white,
                          buttonColor: AppColor.redDefect
                      ),
                    ),
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
                          enabled: true,//selectedCustomers.isNotEmpty,
                          textColor: Colors.white,
                          buttonColor: AppColor.primary
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
                    child: SizedBox(
                      width: 200,
                      child: BaseTextButton(
                          buttonText: "Сохранить задание",
                          onTap: () {}, // viewModel.nextStage(),
                          weight: FontWeight.w500,
                          fontSize: 14,
                          enabled: true,//selectedCustomers.isNotEmpty,
                          textColor: Colors.white,
                          buttonColor: AppColor.primary
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

}