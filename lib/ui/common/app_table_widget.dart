import 'package:flutter/material.dart';

class AppTableWidget extends StatelessWidget {
  final List<DataColumn> dataColumns;
  final List<DataRow> dataRows;

  const AppTableWidget({super.key, required this.dataColumns, required this.dataRows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: dataColumns,
        rows: dataRows,
      ),
    );
  }
}