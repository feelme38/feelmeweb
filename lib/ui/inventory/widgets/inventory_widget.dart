import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget(
      {super.key,
      required this.inventory,
      required this.checkboxValues,
      required this.textControllers});

  final InventoryResponse inventory;
  final Map<String, bool> checkboxValues;
  final Map<String, TextEditingController> textControllers;

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
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

    // Группируем ароматы по названию
    Map<String, double> aromaQuantities = {};
    for (var aroma in inventory.aromas) {
      if (aroma.aroma?.name != null) {
        aromaQuantities.update(
          aroma.aroma!.name!,
          (value) => value + (aroma.quantity ?? 0),
          ifAbsent: () => aroma.quantity ?? 0,
        );
      }
    }

    // Добавляем сгруппированные ароматы
    for (var entry in aromaQuantities.entries) {
      _addRow(rows, 'aroma_${entry.key}', entry.key, entry.value.toString());
    }

    // Добавляем устройства
    for (var device in inventory.devices) {
      _addRow(rows, 'device_${device.id}',
          'Устройство: ${device.model}\nGUID: ${device.id}', '1');
    }

    return rows;
  }

  void _addRow(List<DataRow> rows, String key, String name, String quantity) {
    double maxQuantity =
        double.tryParse(quantity) ?? 0; // максимальное количество

    rows.add(
      DataRow(
        cells: [
          DataCell(Checkbox(
            value: widget.checkboxValues[key],
            onChanged: (value) {
              setState(() {
                widget.checkboxValues[key] = value ?? false;
                if (value == true) {
                  widget.textControllers[key]?.text = quantity;
                }
              });
            },
          )),
          DataCell(Text(name)),
          DataCell(
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  maxLength: 10,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  ],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    counterText: "",
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    hintText: 'Кол-во',
                  ),
                  controller: widget.textControllers[key],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  enabled: !(widget.checkboxValues[key] ?? true),
                  onChanged: (value) {
                    // Если поле пустое, устанавливаем '0'
                    if (value.isEmpty ?? false) {
                      widget.textControllers[key]?.text = '0';
                      return;
                    }

                    // Если значение меньше 0, то возвращаем 0
                    double? inputValue = double.tryParse(value ?? '');
                    if (inputValue != null) {
                      if (inputValue < 0) {
                        widget.textControllers[key]?.text = '0';
                      } else if (inputValue > maxQuantity) {
                        widget.textControllers[key]?.text =
                            maxQuantity.toString();
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
