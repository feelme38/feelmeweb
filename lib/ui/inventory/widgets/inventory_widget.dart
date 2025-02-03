import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({super.key, required this.inventory});

  final InventoryResponse inventory;

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  final Map<String, bool> _checkboxValues = {};
  final Map<String, TextEditingController> _textControllers = {};

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onCheckboxChanged(String key, bool? value) {
    setState(() {
      _checkboxValues[key] = value ?? false;
      if (value == true) {
        _textControllers[key]?.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AppTableWidget(
          dataColumns: _tableColumns,
          dataRows: _getTableInventoryRows(widget.inventory),
        ),
      ),
    );
  }

  final List<DataColumn> _tableColumns = [
    const DataColumn(label: Text('Выбор')),
    const DataColumn(label: Text('Название')),
    const DataColumn(label: Text('Кол-во мл/шт')),
  ];

  List<DataRow> _getTableInventoryRows(InventoryResponse inventory) {
    List<DataRow> rows = [];

    void addRow(String key, String name, String? quantity) {
      _checkboxValues.putIfAbsent(key, () => false);
      _textControllers.putIfAbsent(key, () => TextEditingController());

      rows.add(DataRow(cells: [
        DataCell(Checkbox(
          value: _checkboxValues[key],
          onChanged: (value) => _onCheckboxChanged(key, value),
        )),
        DataCell(Text(name)),
        DataCell(TextField(
          controller: _textControllers[key],
          keyboardType: TextInputType.number,
          enabled: !_checkboxValues[key]!,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Введите кол-во',
          ),
        )),
      ]));
    }

    for (var aroma in inventory.aromas) {
      addRow(
        'aroma_${aroma.aroma?.id}',
        '${aroma.aroma?.name ?? '-'} - ${aroma.quantity.toString()} мл.',
        aroma.quantity.toString(),
      );
    }

    for (var instrument in inventory.instruments) {
      addRow('instrument_$instrument', instrument, null);
    }

    for (var other in inventory.other) {
      addRow('other_$other', other, null);
    }

    return rows;
  }
}
