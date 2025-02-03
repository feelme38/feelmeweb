import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../../common/app_table_widget.dart';

class ChecklistsWidget extends StatefulWidget {
  const ChecklistsWidget({super.key, required this.checklists});

  final List<CheckListInfoResponse> checklists;

  @override
  State<ChecklistsWidget> createState() => _ChecklistsWidgetState();
}

class _ChecklistsWidgetState extends State<ChecklistsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AppTableWidget(
        dataColumns: _tableCustomersColumns,
        dataRows: getTableChecklistsRows(widget.checklists),
      ),
    );
  }

  final List<DataColumn> _tableCustomersColumns = [
    const DataColumn(
        label: Text('Дата прохождения'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Имя клиента'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Ссылка на PDF'),
        headingRowAlignment: MainAxisAlignment.center),
  ];

  List<DataRow> getTableChecklistsRows(
          List<CheckListInfoResponse> checklists) =>
      checklists.map((checklists) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(
                '${checklists.createdAt?.date.toDateTime()} ${checklists.createdAt?.time?.toFormattedTime()}'),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(checklists.customer?.name ?? ''),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.insert_drive_file_outlined),
              onPressed: () {
                final pdfUrl = checklists.pdfUrl; // Убедись, что URL корректный
                if (pdfUrl != null) {
                  html.window.open(pdfUrl, '_blank');
                }
              },
              tooltip: 'Скачать PDF',
            ),
          )),
        ]);
      }).toList();
}
