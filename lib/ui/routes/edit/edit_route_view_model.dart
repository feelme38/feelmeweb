import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/core/constants.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/request/tasks_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/regions/get_available_regions_usecase.dart';
import 'package:feelmeweb/domain/route/change_route_status_usecase.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/domain/route/update_route_usecase.dart';
import 'package:feelmeweb/domain/subtasks/delete_subtask_usecase.dart';
import 'package:feelmeweb/domain/subtasks/get_subtask_types_usecase.dart';
import 'package:feelmeweb/domain/tasks/delete_task_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';

class EditRouteViewModel extends BaseSearchViewModel {
  EditRouteViewModel(this.userId, this.routeDate) {
    loadRoute();
    loadAromas();
    loadSubtaskTypes();
  }

  final _getUserRouteUseCase = GetUserRouteUseCase();
  final _deleteTaskUseCase = DeleteTaskUseCase();
  final _deleteSubtaskUseCase = DeleteSubtaskUseCase();
  final _changeRouteStatusUseCase = ChangeRouteStatusUseCase();
  final _updateRouteUseCase = UpdateRouteUseCase();
  final _getAvailableRegionsUseCase = GetAvailableRegionsUseCase();
  final _getAromasUseCase = GetAromasUseCase();
  final _getSubtaskTypesUseCase = GetSubtaskTypesUseCase();

  final _router = getIt<RouteGenerator>().router;

  final String userId;
  final String routeDate;

  RouteResponse? _route;
  List<RegionResponse> _regions = [];
  final List<CustomerResponse> _customers = [];
  List<AromaResponse> _aromas = [];
  List<SubtaskTypeResponse> _subtaskTypes = [];
  final Map<String, TextEditingController> _fromControllers = {};
  final Map<String, TextEditingController> _toControllers = {};
  final Map<String, TextEditingController> _taskComments = {};
  final Map<String, DateTime?> _visitFromTimes = {};
  final Map<String, DateTime?> _visitToTimes = {};
  bool _hasChanges = false;
  TextEditingController selectedRouteDateController =
      TextEditingController(); // yyyy-MM-dd

  RouteResponse? get route => _route;
  List<RegionResponse> get regions => _regions;
  List<CustomerResponse> get customers => _customers;
  List<AromaResponse> get aromas => _aromas;
  List<SubtaskTypeResponse> get subtaskTypes => _subtaskTypes;
  Map<String, TextEditingController> get taskComments => _taskComments;
  Map<String, TextEditingController> get fromControllers => _fromControllers;
  Map<String, TextEditingController> get toControllers => _toControllers;
  bool get hasChanges => _hasChanges;

  int _creationStage = 1;

  int get creationStage => _creationStage;

  @override
  void dispose() {
    for (final controller in _fromControllers.values) {
      controller.dispose();
    }
    for (final controller in _toControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void nextStage() {
    _creationStage = 2;
    notifyListeners();
  }

  void resetStage() {
    _creationStage = 1;
    notifyListeners();
  }

  void updateSelectedRouteDate(DateTime date) {
    selectedRouteDateController.text = date.toIso8601String().split('T').first;
    _hasChanges = true;
    notifyListeners();
  }

  Future loadRegions() async {
    loadingOn();
    (await executeUseCaseParam<List<RegionResponse>, GetAvailableRegionsParams>(
            _getAvailableRegionsUseCase,
            GetAvailableRegionsParams(
                userId, _route?.routeDate.toIso8601String().split('T').first)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) async {
      _regions = value;
      notifyListeners();
    });
    loadingOff();
  }

  Future loadRoute() async {
    loadingOn();
    (await executeUseCaseParam<RouteResponse, GetUserRouteParam>(
            _getUserRouteUseCase, GetUserRouteParam(userId, routeDate)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _route = (value as RouteResponse).copyWith(
        tasks: value.tasks
            .where(
                (task) => !['CANCELED', 'COMPLETED'].contains(task.taskStatus))
            .map((task) => task.copyWith(
                  subtasks: task.subtasks
                      .where((subtask) => !['CANCELED', 'FINISHED']
                          .contains(subtask.subtaskStatus))
                      .toList(),
                ))
            .toList(),
      );
      if (_route != null) {
        // Prefill date
        selectedRouteDateController.text =
            DateFormat('yyyy-MM-dd').format(_route!.routeDate);
        // Prefill times and comments so UI and payload stay consistent
        for (final task in _route!.tasks) {
          final key = '${task.client.id}_${task.address.id}';

          _visitFromTimes[key] = task.visitTimeFrom;
          _visitToTimes[key] = task.visitTimeTo;
          updateTaskComment(
              task.client.id, task.address.id, task.comment ?? '');
        }
      }
      loadRegions();
      notifyListeners();
    });
    loadingOff();
  }

  Future onDeleteTask(String id) async {
    loadingOn();
    (await executeUseCaseParam<bool, DeleteTaskParam>(
            _deleteTaskUseCase, DeleteTaskParam(id)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Задача успешно удалена', style: AlertStyle.success));
      loadRoute();
    });
    loadingOff();
  }

  Future onDeleteSubtask(String id) async {
    loadingOn();
    (await executeUseCaseParam<bool, DeleteSubtaskParam>(
            _deleteSubtaskUseCase, DeleteSubtaskParam(id)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Подзадача успешно удалена', style: AlertStyle.success));
      loadRoute();
    });
    loadingOff();
  }

  Future onRemoveFromRoute() async {
    loadingOn();
    (await executeUseCaseParam<bool, RouteUpdateBody>(
            _changeRouteStatusUseCase, RouteUpdateBody(route!.id, 'CANCELED')))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(
          Alert('Пользователь снят с маршрута', style: AlertStyle.success));
      Future.delayed(const Duration(milliseconds: 1000), () {
        // Перейти на customerEditRoute
        _router.pushReplacement(RouteName.usersList);
      });
      loadRoute();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  void updateVisitTimeFrom(String customerId, String addressId, String text) {
    _visitFromTimes['${customerId}_$addressId'] = parseTime(text);
    if (_route != null) {
      _route = _route!.copyWith(
        tasks: _route!.tasks.map((task) {
          if (task.client.id == customerId && task.address.id == addressId) {
            return task.copyWith(
                visitTimeFrom: _visitFromTimes['${customerId}_$addressId']);
          }
          return task;
        }).toList(),
      );
    }
    _hasChanges = true;
    notifyListeners();
  }

  void updateVisitTimeTo(String customerId, String addressId, String text) {
    _visitToTimes['${customerId}_$addressId'] = parseTime(text);
    if (_route != null) {
      _route = _route!.copyWith(
        tasks: _route!.tasks.map((task) {
          if (task.client.id == customerId && task.address.id == addressId) {
            return task.copyWith(
                visitTimeTo: _visitToTimes['${customerId}_$addressId']);
          }
          return task;
        }).toList(),
      );
    }
    _hasChanges = true;
    notifyListeners();
  }

  void updateTaskComment(String customerId, String addressId, String text) {
    final key = '${customerId}_$addressId';

    // создаём контроллер, если его ещё нет
    taskComments.putIfAbsent(key, () => TextEditingController());

    _taskComments['${customerId}_$addressId']?.text =
        text.length > 500 ? text.substring(0, 500) : text;
    if (_route != null) {
      _route = _route!.copyWith(
        tasks: _route!.tasks.map((task) {
          if (task.client.id == customerId && task.address.id == addressId) {
            return task.copyWith(
                comment: _taskComments['${customerId}_$addressId']?.text);
          }
          return task;
        }).toList(),
      );
    }
    _hasChanges = true;
    notifyListeners();
  }

  DateTime? parseTime(String timeText) {
    final timeRegex = RegExp(r'^\d{2}:\d{2}$');
    if (!timeRegex.hasMatch(timeText)) return null;

    final timeParts = timeText.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    if (hours > 23 || minutes > 59) return null;

    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hours, minutes);
  }

  Future<void> updateRoute() async {
    if (_route == null) return;

    final tasks = _route!.tasks
        .map((task) => TasksBody(
              id: task.id,
              name: task.name,
              taskStatus: task.taskStatus,
              clientId: task.client.id,
              addressId: task.address.id,
              visitTimeFrom:
                  _visitFromTimes['${task.client.id}_${task.address.id}'],
              visitTimeTo:
                  _visitToTimes['${task.client.id}_${task.address.id}'],
              comment:
                  _taskComments['${task.client.id}_${task.address.id}']?.text,
              subtasks: task.subtasks
                  .map(
                    (subtask) => SubtaskBody(
                        task.client.id,
                        subtask.device.id,
                        subtask.comment,
                        subtask.expectedAroma.id,
                        subtask.expectedAromaVolume,
                        subtask.volumeFormula ??
                            Constants.aromaFormulasList.last, // volumeFormula
                        subtask.contractType ??
                            Constants.contractTypesList.first,
                        subtask.subtaskType.id,
                        id: subtask.id,
                        subtaskStatus: subtask.subtaskStatus),
                  )
                  .toList(),
            ))
        .toList();

    final RouteBody routeBody = RouteBody(userId, tasks,
        routeId: _route?.id,
        routeStatus: _route?.routeStatus,
        routeDate: selectedRouteDateController.text);
    loadingOn();
    (await executeUseCaseParam<void, RouteBody>(_updateRouteUseCase, routeBody))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Маршрут успешно обновлен', style: AlertStyle.success));
      _hasChanges = false;
      notifyListeners();
    });
    loadingOff();
  }

  Future<void> onEditSubtask(SubtaskBody updatedSubtask) async {
    if (_route == null) return;

    final updatedTasks = _route!.tasks.map((task) {
      final updatedSubtasks = task.subtasks.map((subtask) {
        if (subtask.id == updatedSubtask.id) {
          final aroma = aromas
              .firstWhereOrNull((e) => e.id == updatedSubtask.expectedAromaId);
          final type = subtaskTypes
              .firstWhereOrNull((e) => e.id == updatedSubtask.typeId);
          // Convert SubtaskBody back to Subtask
          return subtask.copyWith(
              comment: updatedSubtask.comment,
              expectedAroma: Aroma(id: aroma!.id, name: aroma.name),
              expectedAromaVolume: updatedSubtask.expectedAromaVolume,
              volumeFormula: updatedSubtask.volumeFormula,
              subtaskType: type);
        }
        return subtask;
      }).toList();

      return task.copyWith(subtasks: updatedSubtasks);
    }).toList();

    _route = _route!.copyWith(tasks: updatedTasks);
    _hasChanges = true;
    notifyListeners();
  }

  String getLastVisitDate(String customerId, String addressId) {
    final task = _route?.tasks.firstWhereOrNull(
      (task) => task.client.id == customerId && task.address.id == addressId,
    );

    if (task == null || task.subtasks.isEmpty) {
      return " – ";
    }

    final lastSubtask = task.subtasks.last;
    if (lastSubtask.checklist?.createdAt == null) {
      return " – ";
    }
    return DateFormat('dd.MM.yyyy').format(lastSubtask.checklist!.createdAt!);
  }

  Future<void> loadAromas() async {
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

  Future<void> loadSubtaskTypes() async {
    loadingOn();
    (await executeUseCase<List<SubtaskTypeResponse>>(_getSubtaskTypesUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _subtaskTypes = value;
      notifyListeners();
    });
    loadingOff();
  }

  @override
  String get title => 'Редактирование маршрутного листа';
}
