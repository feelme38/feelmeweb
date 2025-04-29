import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/routes/create/widgets/choose_subtasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_route_view_model.dart';

class CreateRouteSubtasksWidget extends StatelessWidget {
  const CreateRouteSubtasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>();

    final isCreateOrUpdateRouteButtonEnabled = context
        .watch<CreateRouteViewModel>()
        .isCreateOrUpdateRouteButtonEnabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 1, child: CreateRouteChooseSubtasksWidget()),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 32),
                child: SizedBox(
                    width: 200,
                    child: BaseTextButton(
                        buttonText: viewModel.isUpdate
                            ? "Обновить маршрут"
                            : "Создать маршрут",
                        onTap: () => viewModel.isUpdate
                            ? viewModel.updateRoute()
                            : viewModel.createRoute(),
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: isCreateOrUpdateRouteButtonEnabled,
                        textColor: Colors.white,
                        buttonColor: AppColor.redDefect))),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32, 32),
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
          ],
        )
      ],
    );
  }
}
