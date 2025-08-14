import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:flutter/material.dart';

class AppTableWidget extends StatelessWidget {
  final List<DataColumn> dataColumns;
  final List<DataRow> dataRows;

  AppTableWidget(
      {super.key, required this.dataColumns, required this.dataRows});

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
            showCheckboxColumn: false,
            columns: dataColumns,
            rows: dataRows,
          ),
        ),
      ),
    );
  }

  static DataColumn getCustomColumn({String? text, Widget? widget}) {
    return DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      label: text != null ? Text(text) : widget ?? const SizedBox(),
    );
  }

  static DataCell getCustomCell({String? text, Widget? widget}) {
    return DataCell(
      Align(
        alignment: Alignment.center,
        child: widget ?? Text(text.orDash()),
      ),
    );
  }
}
