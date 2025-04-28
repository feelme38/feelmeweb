import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/core/date_utils.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';

typedef ToggleCustomerCallback = void Function(SubtaskBody);

class EditSubtasksWidget extends StatefulWidget {
  const EditSubtasksWidget(
      {super.key,
      required this.task,
      required this.onDeleteSubtask,
      required this.checklists});

  final Task task;
  final List<LastCheckListInfoResponse> checklists;
  final Function(String subtaskId) onDeleteSubtask;

  @override
  State<EditSubtasksWidget> createState() => _EditSubtasksWidgetState();
}

class _EditSubtasksWidgetState extends State<EditSubtasksWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AppTableWidget(
          dataColumns: _tableChecklistColumns,
          dataRows: _getTableChecklistRows(widget.task.subtasks),
        ),
      ),
    );
  }

  final List<DataColumn> _tableChecklistColumns = [
    AppTableWidget.getCustomColumn(text: 'Устройство'),
    AppTableWidget.getCustomColumn(text: 'Время посещения'),
    AppTableWidget.getCustomColumn(text: 'Тип подзадачи'),
    AppTableWidget.getCustomColumn(text: 'Аромат'),
    AppTableWidget.getCustomColumn(text: 'Остаток аромата'),
    AppTableWidget.getCustomColumn(text: 'Формула'),
    AppTableWidget.getCustomColumn(text: 'Расположение'),
    AppTableWidget.getCustomColumn(text: 'Режим работы'),
    AppTableWidget.getCustomColumn(text: 'Тип сотрудничества'),
    AppTableWidget.getCustomColumn(text: 'Ожидаемый аромат'),
    AppTableWidget.getCustomColumn(text: 'Объем ожид. аромата'),
    AppTableWidget.getCustomColumn(text: 'Комментарий'),
    AppTableWidget.getCustomColumn(
        widget: const SizedBox()), // пустой заголовок для последней колонки
  ];

  List<DataRow> _getTableChecklistRows(List<Subtask> subtasks) => subtasks
          .asMap()
          .entries
          .where((entry) =>
              !['CANCELED', 'FINISHED'].contains(entry.value.subtaskStatus))
          .map((entry) {
        final Subtask subtask = entry.value;
        final LastCheckListInfoResponse? checklist = widget.checklists
            .firstWhereOrNull((e) => e.deviceId == subtask.device.id);

        return DataRow(
          color: const WidgetStatePropertyAll(AppColor.background),
          cells: [
            AppTableWidget.getCustomCell(text: subtask.device.model),
            AppTableWidget.getCustomCell(
              text: widget.task.visitDateTime != null
                  ? DateFormat(DateFormats.HHmm)
                      .format(widget.task.visitDateTime!)
                  : null,
            ),
            AppTableWidget.getCustomCell(text: subtask.subtaskType.name),
            AppTableWidget.getCustomCell(
                text: checklist?.checklistAroma.newAromaName),
            AppTableWidget.getCustomCell(
                text: checklist?.checklistAroma.volumeMl.toString()),
            AppTableWidget.getCustomCell(text: subtask.volumeFormula),
            AppTableWidget.getCustomCell(text: subtask.device.place),
            AppTableWidget.getCustomCell(text: 'Режим работы'),
            AppTableWidget.getCustomCell(text: subtask.device.contract),
            AppTableWidget.getCustomCell(text: subtask.expectedAroma.name),
            AppTableWidget.getCustomCell(
                text: subtask.expectedAromaVolume.toString()),
            AppTableWidget.getCustomCell(text: subtask.comment),
            AppTableWidget.getCustomCell(
              widget: IconButton(
                  icon: const Icon(Icons.delete, color: AppColor.redDefect),
                  onPressed: () => widget.onDeleteSubtask(subtask.id),
                  tooltip: 'Удалить'),
            ),
          ],
        );
      }).toList();
}
