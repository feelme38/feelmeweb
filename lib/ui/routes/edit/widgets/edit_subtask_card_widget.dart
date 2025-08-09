import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/routes/create/widgets/subtask_parameters_widget.dart';
import 'package:feelmeweb/ui/routes/edit/edit_route_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSubtaskCardWidget extends StatelessWidget {
  final LastCheckListInfoResponse checklist;
  final Subtask subtask;
  final Task task;

  const EditSubtaskCardWidget({
    super.key,
    required this.checklist,
    required this.subtask,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EditRouteViewModel>();

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 400,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtaskParametersWidget(
                  param: 'Устройство', value: checklist.deviceModel.orDash()),
              const SizedBox(height: 16),
              SubtaskParametersWidget(
                  param: 'Юр. лицо', value: task.client.name.orDash()),
              SubtaskParametersWidget(
                  param: 'ЛПР', value: task.client.ownerName.orDash()),
              SubtaskParametersWidget(
                  param: 'Телефон', value: task.client.phone.orDash()),
              const SizedBox(height: 16),
              SubtaskParametersWidget(
                  param: 'Адрес', value: task.address.address.orDash()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: BaseTextButton(
                        buttonText: "Редактировать",
                        onTap: () {
                          Dialogs.editSubtaskDialog(context,
                              checklist: checklist,
                              aromas: viewModel.aromas,
                              subtaskTypes: viewModel.subtaskTypes,
                              editSubtaskCallback: viewModel.onEditSubtask,
                              subtask: subtask);
                        },
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: true,
                        textColor: Colors.white,
                        buttonColor: AppColor.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BaseTextButton(
                        buttonText: "Удалить",
                        onTap: () => viewModel.onDeleteSubtask(subtask.id),
                        weight: FontWeight.w500,
                        fontSize: 14,
                        enabled: true,
                        textColor: Colors.white,
                        buttonColor: AppColor.redDefect),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
