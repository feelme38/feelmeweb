import 'package:base_class_gen/core/ext/string_ext.dart';
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
    final selectedCustomers = context.watch<CreateRouteViewModel>().selectedCustomers;
    final checklists = context.watch<CreateRouteViewModel>().lastChecklists;

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
                  viewModel.loadLastChecklistsInfo(customerId: customer.id);
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
              Column(
                children: [
                  Text("Наименование юр. лица"),
                  Text("ЛПР - Телефон"),
                  Text("Дата последнего посещения"),
                  Text("Тип задания"),
                  ListView.builder(
                    itemCount: checklists.length,
                    itemBuilder: (context, index) {
                      final checklist = checklists[index];
                      return ListTile(
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    checklist.deviceModel.orEmpty,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    checklist.checklistAroma.volumeMl.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
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