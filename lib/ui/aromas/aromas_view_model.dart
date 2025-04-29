import 'package:feelmeweb/data/models/request/update_aroma_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/domain/aromas/delete_aroma_use_case.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/aromas/update_aroma_use_case.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';

class AromasViewModel extends BaseSearchViewModel {
  AromasViewModel() {
    loadAromas();
  }

  final _getAromasUseCase = GetAromasUseCase();
  final _deleteAromaUseCase = DeleteAromaUseCase();
  final _updateAromaUseCase = UpdateAromaUseCase();

  List<AromaResponse> _aromas = [];
  List<AromaResponse> get aromas => _aromas;

  Map<AromaType, List<AromaResponse>> get aromasByType {
    final Map<AromaType, List<AromaResponse>> result = {};
    for (var aroma in _aromas) {
      final type = aroma.type;
      if (type == null) continue;
      if (!result.containsKey(type)) {
        result[type] = [];
      }
      result[type]!.add(aroma);
    }
    return result;
  }

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

  void deleteAromas(String aromaId) async {
    loadingOn();
    (await executeUseCaseParam<void, String>(_deleteAromaUseCase, aromaId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Аромат удален', style: AlertStyle.success));
      loadAromas();
    });
    loadingOff();
  }

  void updateAromas(UpdateAromaBody body) async {
    loadingOn();
    (await executeUseCaseParam<bool, UpdateAromaBody>(
            _updateAromaUseCase, body))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Аромат обновлен', style: AlertStyle.success));
      loadAromas();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  List<DataRow> getTableAromasRows(
          List<AromaResponse> aromas, AromaType type, BuildContext context) =>
      aromas.where((e) => e.type == type).map((aroma) {
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
                  Dialogs.updateAromaDialog(context, aroma, updateAromas);
                },
                tooltip: 'Редактировать',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteAromas(aroma.id);
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
