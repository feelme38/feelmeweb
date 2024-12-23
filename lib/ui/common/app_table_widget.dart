import 'package:flutter/material.dart';

class AppTableWidget extends StatelessWidget {
  final List<DataColumn> dataColumns;
  final List<DataRow> dataRows;

  AppTableWidget({super.key, required this.dataColumns, required this.dataRows});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: DataTable(
            columns: dataColumns,
            rows: dataRows,
          ),
        ),
      ),
    );
  }
}