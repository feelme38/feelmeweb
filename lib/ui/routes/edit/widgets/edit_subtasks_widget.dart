import 'package:collection/collection.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
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
      required this.subtasks,
      required this.onDeleteSubtask,
      required this.checklists});

  final List<Subtask> subtasks;
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
          dataRows: _getTableChecklistRows(widget.subtasks),
        ),
      ),
    );
  }

  final List<DataColumn> _tableChecklistColumns = [
    const DataColumn(label: Text('Устройство')),
    const DataColumn(label: Text('Аромат')),
    const DataColumn(label: Text('Остаток аромата')),
    const DataColumn(label: Text('Расположение')),
    const DataColumn(label: Text('Режим работы')),
    const DataColumn(label: Text('Тип сотрудничества')),
    const DataColumn(label: Text('Время выполнения, мин')),
    const DataColumn(label: Text('Ожидаемый аромат')),
    const DataColumn(label: Text('Объем ожид. аромата')),
    const DataColumn(label: Text('Комментарий')),
    const DataColumn(label: SizedBox()),
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
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.device.model.orDash()),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child:
                  Text(checklist?.checklistAroma.newAromaName.orDash() ?? '-'),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(
                  checklist?.checklistAroma.volumeMl.toString().orDash() ??
                      '-'),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.device.place.orDash()),
            )),
            const DataCell(Align(
              alignment: Alignment.center,
              child: Text('Режим работы'),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.device.contract.orDash()),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.estimatedCompletedTime.toString().orDash()),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.expectedAroma.name.orDash()),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.expectedAromaVolume.toString().orDash()),
            )),
            DataCell(Align(
              alignment: Alignment.center,
              child: Text(subtask.comment.orDash()),
            )),
            DataCell(
              Align(
                alignment: Alignment.center,
                child: IconButton(
                    icon: const Icon(Icons.delete, color: AppColor.redDefect),
                    onPressed: () => widget.onDeleteSubtask(subtask.id),
                    tooltip: 'Удалить'),
              ),
            ),
          ],
        );
      }).toList();
}
