import 'package:feelmeweb/data/models/request/update_device_model_body.dart';
import 'package:feelmeweb/data/models/response/device_models.dart';
import 'package:feelmeweb/domain/devices/delete_device_model_use_case.dart';
import 'package:feelmeweb/domain/devices/get_device_models_use_case.dart';
import 'package:feelmeweb/domain/devices/update_device_model_use_case.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class DeviceModelsViewModel extends BaseSearchViewModel {
  DeviceModelsViewModel() {
    loadDeviceModels();
  }

  final _getDeviceModelsUseCase = GetDeviceModelsUseCase();
  final _updateDeviceModelUseCase = UpdateDeviceModelUseCase();
  final _deleteDeviceModelUseCase = DeleteDeviceModelUseCase();

  List<DeviceModelsResponse> _deviceModels = [];
  List<DeviceModelsResponse> get deviceModels => _deviceModels;

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  final List<DataColumn> _tableDeviceModelsColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('Тип')),
    const DataColumn(label: Text('')),
  ];
  List<DataColumn> get tableDeviceModelsColumns => _tableDeviceModelsColumns;

  void loadDeviceModels() async {
    loadingOn();
    _getDeviceModelsUseCase().then((v) {
      v.doOnSuccess((data) {
        _deviceModels = data;
        notifyListeners();
      });
    });
    loadingOff();
  }

  void updateDeviceModel(UpdateDeviceModelBody body) async {
    loadingOn();
    (await executeUseCaseParam<bool, UpdateDeviceModelBody>(
            _updateDeviceModelUseCase, body))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Модель устройства обновлена', style: AlertStyle.success));
      loadDeviceModels();
    });
    loadingOff();
  }

  void deleteDeviceModel(String modelId) async {
    loadingOn();
    (await executeUseCaseParam<bool, String>(
            _deleteDeviceModelUseCase, modelId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((_) {
      addAlert(Alert('Модель устройства удалена', style: AlertStyle.success));
      loadDeviceModels();
    });
    loadingOff();
  }

  List<DataRow> getTableDeviceModelsRows(
          List<DeviceModelsResponse> models, BuildContext context) =>
      models.map((model) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(model.name),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(model.worker_type.name),
          )),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Dialogs.updateDeviceModelDialog(
                      context, model, updateDeviceModel);
                },
                tooltip: 'Редактировать',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteDeviceModel(model.id);
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
