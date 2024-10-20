import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class AromasViewModel extends BaseSearchViewModel {

  AromasViewModel() {
    loadAromas();
  }

  final _getAromasUseCase = GetAromasUseCase();

  List<AromaResponse> _aromas = [];
  List<AromaResponse> get aromas => _aromas;

  final List<DataColumn> _tableAromasColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('')),
  ];
  List<DataColumn> get tableAromasColumns => _tableAromasColumns;

  void loadAromas() async {
    loadingOn();
    (await executeUseCase<List<AromaResponse>>(_getAromasUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _aromas = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  List<DataRow> getTableAromasRows(List<AromaResponse> aromas) => aromas.map((aroma) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(aroma.name),
          )
      ),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Логика редактирования пользователя
            },
            tooltip: 'Редактировать',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Логика удаления пользователя
            },
            tooltip: 'Удалить',
          ),
        ],
      )),
    ]);
  }).toList();

  @override
  String get title => 'Ароматы';
}