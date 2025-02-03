import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class RegionsViewModel extends BaseSearchViewModel {

  RegionsViewModel() {
    loadRegions();
  }

  final _getRegionsUseCase = GetRegionsUseCase();

  List<RegionResponse> _regions = [];
  List<RegionResponse> get regions => _regions;

  final List<DataColumn> _tableRegionsColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('')),
  ];
  List<DataColumn> get tableRegionsColumns => _tableRegionsColumns;

  void loadRegions() async {
    loadingOn();
    (await executeUseCase<List<RegionResponse>>(_getRegionsUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _regions = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  List<DataRow> getTableRegionsRows(List<RegionResponse> regions) => regions.map((region) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(region.name),
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
  String get title => 'Районы';
}