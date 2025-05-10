import 'package:feelmeweb/data/models/request/update_region_body.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/regions/delete_region_use_case.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/domain/regions/update_region_use_case.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class RegionsViewModel extends BaseSearchViewModel {
  RegionsViewModel() {
    loadRegions();
  }

  final _getRegionsUseCase = GetRegionsUseCase();
  final _updateRegionUseCase = UpdateRegionUseCase();
  final _deleteRegionUseCase = DeleteRegionUseCase();

  List<RegionResponse> get regions => _filteredRegions;

  List<RegionResponse> _filteredRegions = [];
  List<RegionResponse> _regions = [];

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
      _filteredRegions = value;
      notifyListeners();
    });
    loadingOff();
  }

  void updateRegion(UpdateRegionBody body) async {
    loadingOn();
    (await executeUseCaseParam<bool, UpdateRegionBody>(
            _updateRegionUseCase, body))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Район обновлен', style: AlertStyle.success));
      loadRegions();
    });
    loadingOff();
  }

  void deleteRegion(String id) async {
    loadingOn();
    (await executeUseCaseParam<bool, String>(_deleteRegionUseCase, id))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Район удален', style: AlertStyle.success));
      loadRegions();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    if (text == null || text.isEmpty) {
      _filteredRegions = _regions;
    } else {
      _filteredRegions = _regions
          .where((customer) =>
              customer.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  List<DataRow> getTableRegionsRows(
          List<RegionResponse> regions, BuildContext context) =>
      regions.map((region) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(region.name),
          )),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Dialogs.showUpdateRegionDialog(context, region, updateRegion);
                },
                tooltip: 'Редактировать',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteRegion(region.id);
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
