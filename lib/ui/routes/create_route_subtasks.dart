import 'package:feelmeweb/presentation/widgets/circled_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/buttons/base_text_button.dart';
import '../../presentation/theme/theme_colors.dart';
import 'create_route_view_model.dart';

class CreateRouteSubtasksWidget extends StatelessWidget {

  const CreateRouteSubtasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>()
      ..chooseDefaultCustomer();
    final selectedCustomers = context.watch<CreateRouteViewModel>().selectedCustomers;

    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: selectedCustomers.length,
            itemBuilder: (context, index) {
              final customer = selectedCustomers[index];
             final isSelectedCustomer = viewModel.selectedCustomerId == customer.id;
              return ListTile(
                title: Text(customer.name),
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
              const Expanded(
                child: SizedBox(),
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