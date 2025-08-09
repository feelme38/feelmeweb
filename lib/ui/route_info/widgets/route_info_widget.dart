import 'dart:html' as html;

import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:flutter/material.dart';

import '../../common/app_table_widget.dart';

class RouteInfoWidget extends StatefulWidget {
  const RouteInfoWidget({super.key, required this.subtasks});

  final List<Subtask> subtasks;

  @override
  State<RouteInfoWidget> createState() => _RouteInfoWidgetState();
}

class _RouteInfoWidgetState extends State<RouteInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AppTableWidget(
        dataColumns: _tableCustomersColumns,
        dataRows: getTableRouteInfoRows(widget.subtasks),
      ),
    );
  }

  final List<DataColumn> _tableCustomersColumns = [
    const DataColumn(
        label: Text('Чек-лист'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Время начала работ'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Время окончания работ'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Ориентировочное время прибытия'),
        headingRowAlignment: MainAxisAlignment.center),
  ];

  List<DataRow> getTableRouteInfoRows(List<Subtask> subtasks) =>
      subtasks.map((subtask) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: IconButton(
                icon: const Icon(Icons.insert_drive_file_outlined),
                onPressed: subtask.checklist != null
                    ? () {
                        final pdfUrl = subtask.checklist?.pdfUrl ?? '';
                        html.window.open(pdfUrl, '_blank');
                      }
                    : null,
                tooltip: 'Скачать PDF'),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(subtask.startAt.orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(subtask.endAt.orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(subtask.arrivalTime.orDash()),
          )),
        ]);
      }).toList();
}
