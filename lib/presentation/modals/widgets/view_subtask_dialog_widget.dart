import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/routes/create/widgets/subtask_parameters_widget.dart';
import 'package:flutter/material.dart';

class ViewSubtaskDialogWidget extends StatelessWidget {
  const ViewSubtaskDialogWidget({
    super.key,
    required this.checklist,
    required this.subtask,
  });

  final LastCheckListInfoResponse checklist;
  final Subtask subtask;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Информация о подзадаче',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SubtaskParametersWidget(
                      param: 'Устройство',
                      value: checklist.deviceModel.orDash()),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Расположение',
                      value: checklist.deviceLocation.orDash()),
                  const SizedBox(height: 16),
                  const SubtaskParametersWidget(
                      param: 'Режим работы', value: 'Режим работы'),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Тип сотрудничества',
                      value: checklist.contract.orDash()),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Текущий аромат',
                      value: checklist.checklistAroma.newAromaName.orDash()),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Остаток аромата',
                      value: checklist.checklistAroma.volumeMl
                          .toString()
                          .orDash()),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Тип подзадачи', value: subtask.subtaskType.name),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Ожидаемый аромат',
                      value: subtask.expectedAroma?.name),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Объем ожид. аромата',
                      value: subtask.expectedAromaVolume.toString()),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Формула', value: subtask.volumeFormula),
                  const SizedBox(height: 16),
                  SubtaskParametersWidget(
                      param: 'Комментарий', value: subtask.comment),
                  const SizedBox(height: 24),
                  BaseTextButton(
                    buttonText: "Закрыть",
                    onTap: context.navigateUp,
                    enabled: true,
                    buttonColor: AppColor.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
