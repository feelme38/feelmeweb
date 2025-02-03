import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:flutter/material.dart';

import '../../common/app_table_widget.dart';

class RouteInfoWidget extends StatefulWidget {
  const RouteInfoWidget({super.key, required this.tasks});

  final List<Task> tasks;

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
        dataRows: getTableRouteInfoRows(widget.tasks),
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

  List<DataRow> getTableRouteInfoRows(List<Task> tasks) => tasks.map((task) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(task.completedTime.toString().orDash()),
          )),
          const DataCell(Align(
            alignment: Alignment.center,
            child: Text(''),
          )),
          const DataCell(Align(
            alignment: Alignment.center,
            child: Text(''),
          )),
        ]);
      }).toList();
}
