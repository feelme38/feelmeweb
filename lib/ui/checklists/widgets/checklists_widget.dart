import 'dart:html' as html;

import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../../common/app_table_widget.dart';

class ChecklistsWidget extends StatefulWidget {
  const ChecklistsWidget({
    super.key,
    required this.checklists,
    required this.engineers,
    required this.selectedEngineer,
    required this.selectedDate,
    required this.selectedChecklist,
    required this.onEngineerChanged,
    required this.onDateChanged,
    required this.onChecklistSelected,
  });

  final List<ChecklistResponseItem> checklists;
  final List<UserResponse> engineers;
  final UserResponse? selectedEngineer;
  final DateTime? selectedDate;
  final ChecklistResponseItem? selectedChecklist;
  final Function(UserResponse?) onEngineerChanged;
  final Function(DateTime?) onDateChanged;
  final Function(ChecklistResponseItem) onChecklistSelected;

  @override
  State<ChecklistsWidget> createState() => _ChecklistsWidgetState();
}

class _ChecklistsWidgetState extends State<ChecklistsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AppTableWidget(
              dataColumns: _tableChecklistsColumns,
              dataRows: getTableChecklistsRows(widget.checklists),
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> get _tableChecklistsColumns => [
        const DataColumn(label: Text('Выбор')),
        DataColumn(
          headingRowAlignment: MainAxisAlignment.center,
          label: GestureDetector(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year - 1),
                lastDate: DateTime(now.year + 2),
                locale: const Locale('ru'),
              );
              if (picked != null) widget.onDateChanged(picked);
            },
            child: Row(
              children: [
                Text(
                  'Дата прохождения',
                  style: TextStyle(
                      color: widget.selectedDate != null ? Colors.blue : null),
                ),
                if (widget.selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: () => widget.onDateChanged(null),
                      child:
                          const Icon(Icons.close, color: Colors.blue, size: 15),
                    ),
                  )
                else
                  const Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
        DataColumn(
          headingRowAlignment: MainAxisAlignment.center,
          label: DropdownButton<UserResponse>(
            underline: Container(),
            value: widget.selectedEngineer,
            items: [
              const DropdownMenuItem<UserResponse>(
                  value: null, child: Text('Все')),
              ...widget.engineers.map((e) => DropdownMenuItem<UserResponse>(
                    value: e,
                    child: Text(
                      e.name,
                    ),
                  )),
            ],
            onChanged: widget.onEngineerChanged,
            isDense: true,
            iconDisabledColor:
                widget.selectedEngineer != null ? AppColor.primary : null,
            iconEnabledColor:
                widget.selectedEngineer != null ? AppColor.primary : null,
            selectedItemBuilder: (BuildContext context) => List.generate(
              4,
              (index) => Text(
                'Имя инженера',
                style: TextStyle(
                    color:
                        widget.selectedEngineer != null ? Colors.blue : null),
              ),
            ),
          ),
        ),
        const DataColumn(
            label: Text('Ссылка на PDF'),
            headingRowAlignment: MainAxisAlignment.center),
      ];

  List<DataRow> getTableChecklistsRows(
          List<ChecklistResponseItem> checklists) =>
      checklists.map((checklist) {
        DateTime? createdAt = checklist.createdAt;
        String formattedDate = " – ";
        formattedDate = DateFormat('dd.MM.yyyy HH:mm:ss').format(createdAt);

        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Checkbox(
              value: checklist == widget.selectedChecklist,
              onChanged: (value) => widget.onChecklistSelected(checklist),
            ),
          )),
          DataCell(
            Align(
              alignment: Alignment.center,
              child: Text(formattedDate),
            ),
          ),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(checklist.engineer.name),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.insert_drive_file_outlined),
              onPressed: () {
                final pdfUrl = checklist.pdfUrl;
                html.window.open(pdfUrl, '_blank');
              },
              tooltip: 'Скачать PDF',
            ),
          )),
        ]);
      }).toList();
}
