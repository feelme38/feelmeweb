import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:feelmeweb/domain/devices/get_device_models_use_case.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeviceModelsViewModel extends BaseSearchViewModel {
  DeviceModelsViewModel() {
    loadDeviceModels();
  }

  final _getDeviceModelsUseCase = GetDeviceModelsUseCase();

  List<DeviceModelResponse> _deviceModels = [];
  List<DeviceModelResponse> get deviceModels => _deviceModels;

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  final List<DataColumn> _tableDeviceModelsColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('')),
  ];
  List<DataColumn> get tableDeviceModelsColumns => _tableDeviceModelsColumns;

  void loadDeviceModels() async {
    loadingOn();
    (await executeUseCase<List<DeviceModelResponse>>(_getDeviceModelsUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _deviceModels = value;
      notifyListeners();
    });
    loadingOff();
  }

  List<DataRow> getTableDeviceModelsRows(List<DeviceModelResponse> aromas) =>
      aromas.map((aroma) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(aroma.name),
          )),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //Dialogs.createDeviceModelsDialog(
                  //null, (body) => updateDeviceModels(body, reloadCallback));
                },
                tooltip: 'Редактировать',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  //deleteDeviceModels(aroma.id);
                },
                tooltip: 'Удалить',
              ),
            ],
          )),
        ]);
      }).toList();
}

@override
String get title => 'Типы оборудования';
