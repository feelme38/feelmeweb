
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_table_widget.dart';

typedef ToggleCustomerCallback = void Function(CheckListInfoResponse);

class CreateRouteChooseSubtasksWidget extends StatefulWidget {

  CreateRouteChooseSubtasksWidget({
    super.key,
    required this.checklists,
    required this.selectedChecklists,
    required this.toggleCallback,
    required this.aromas
  });

  final List<CheckListInfoResponse> checklists;
  final List<CheckListInfoResponse> selectedChecklists;
  final List<AromaResponse> aromas;
  final ToggleCustomerCallback toggleCallback;

  final TextEditingController estimatedTimeController = TextEditingController();
  final TextEditingController expectedAromaVolumeController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  State<CreateRouteChooseSubtasksWidget> createState() => _CreateRouteChooseSubtasksWidgetState();
}

class _CreateRouteChooseSubtasksWidgetState extends State<CreateRouteChooseSubtasksWidget> {

  late AromaResponse? selectedAroma = widget.aromas.firstOrNull;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AppTableWidget(
          dataColumns: _tableChecklistColumns,
          dataRows: _getTableChecklistRows(widget.checklists, widget.aromas),
        ),
      ),
    );
  }

  final List<DataColumn> _tableChecklistColumns = [
    const DataColumn(label: Text('Выбор')),
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
  ];

  List<DataRow> _getTableChecklistRows(
      List<CheckListInfoResponse> checklists,
      List<AromaResponse> aromas
  ) => checklists.map((checklist) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Checkbox(
              value: widget.selectedChecklists.map((e) => e.id).contains(checklist.id),
              onChanged: (_) {
                widget.toggleCallback.call(checklist);
                setState(() {});
              },
            ),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(checklist.deviceModel.orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(checklist.checklistAroma.newAromaName.orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(checklist.checklistAroma.volumeMl.toString().orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(checklist.deviceLocation.orDash()),
          )
      ),
      const DataCell(
          Align(
            alignment: Alignment.center,
            child: Text('Режим работы'),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(checklist.contract.orDash()),
          )
      ),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 100,
            child: TextFormField(
              maxLines: 1,
              maxLength: 10,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Разрешает только цифры
              ],
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                counterText: "",
                isDense: true, // уменьшает высоту поля
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // регулирует отступы
                labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0), // скругленные углы
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы
                    width: 1.5, // толщина границы
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы, когда поле не в фокусе
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.blue, // цвет границы, когда поле в фокусе
                    width: 1.5,
                  ),
                ),
              ),
              controller: widget.estimatedTimeController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: DropdownButton(
              value: selectedAroma,
              onChanged: (newValue) {
                selectedAroma = newValue;
                setState(() {});
              },
              items: aromas.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: SizedBox(
                    width: 150,
                    child: Text(e.name),
                  ),
                );
              }).toList(),
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          )
      ),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 100,
            child: TextFormField(
              maxLines: 1,
              maxLength: 10,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Разрешает только цифры
              ],
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                counterText: "",
                isDense: true, // уменьшает высоту поля
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // регулирует отступы
                labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0), // скругленные углы
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы
                    width: 1.5, // толщина границы
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы, когда поле не в фокусе
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.blue, // цвет границы, когда поле в фокусе
                    width: 1.5,
                  ),
                ),
              ),
              controller: widget.expectedAromaVolumeController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 300,
            child: TextFormField(
              minLines: 1,
              maxLines: null,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true, // уменьшает высоту поля
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // регулирует отступы
                labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0), // скругленные углы
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы
                    width: 1.5, // толщина границы
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.grey, // цвет границы, когда поле не в фокусе
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Colors.blue, // цвет границы, когда поле в фокусе
                    width: 1.5,
                  ),
                ),
              ),
              controller: widget.commentController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
    ]);
  }).toList();
}