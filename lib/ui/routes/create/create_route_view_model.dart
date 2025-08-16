import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/core/constants.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/list_ext.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/request/tasks_body.dart';
import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_available_checklists_usecase.dart';
import 'package:feelmeweb/domain/customers/get_available_customers_usecase.dart';
import 'package:feelmeweb/domain/regions/get_available_regions_usecase.dart';
import 'package:feelmeweb/domain/route/create_route_usecase.dart';
import 'package:feelmeweb/domain/route/get_route_by_id_usecase.dart';
import 'package:feelmeweb/domain/route/update_route_usecase.dart';
import 'package:feelmeweb/domain/subtasks/get_subtask_types_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';

import '../../../core/date_utils.dart';

class CreateRouteViewModel extends BaseSearchViewModel {
  CreateRouteViewModel(this.userId, this.routeId) {
    Future.microtask(() async {
      if (routeId != null) {
        await getUserRoute();
      }
      loadRegions();
      loadAromas();
      loadTaskTypes();
    });
  }

  final _getAvailableRegionsUseCase = GetAvailableRegionsUseCase();
  final _getAvailableCustomersUseCase = GetAvailableCustomersUseCase();
  final _getAvailableChecklistsUseCase = GetAvailableChecklistsUseCase();
  final _getAromasUseCase = GetAromasUseCase();
  final _getSubtaskTypesUseCase = GetSubtaskTypesUseCase();
  final _createRouteUseCase = CreateRouteUseCase();
  final _updateRouteUseCase = UpdateRouteUseCase();
  final _getRouteByIdUseCase = GetRouteByIdUseCase();

  final _router = getIt<RouteGenerator>().router;

  final String userId;
  final String? routeId;

  List<RegionResponse> _regions = [];

  List<RegionResponse> get regions => _regions;

  List<CustomerResponse> _customers = [];

  List<CustomerResponse> get customers => _customers;

  final List<LastCheckListInfoResponse> _lastChecklists = [];

  List<LastCheckListInfoResponse> get lastChecklists => _lastChecklists;

  List<AromaResponse> _aromas = [];

  List<AromaResponse> get aromas => _aromas;

  List<SubtaskTypeResponse> _subtaskTypes = [];

  List<SubtaskTypeResponse> get subtaskTypes => _subtaskTypes;

  RouteResponse? _route;

  RouteResponse? get route => _route;

  // активно тогда, и только тогда, когда по каждому клиенту есть 1 Task и в каждой Task по 1 Subtask
  bool _isCreateOrUpdateRouteButtonEnabled = false;

  bool get isCreateOrUpdateRouteButtonEnabled =>
      _isCreateOrUpdateRouteButtonEnabled;

  String? selectedRegionId;

  final List<CustomerResponse> selectedCustomers = [];
  final List<SubtaskBody> selectedSubtasks = [];
  final Map<String, TasksBody> savedTasks = {};
  final Map<String, TextEditingController> taskComments = {};
  final Map<String, DateTime?> visitFromTimes = {};
  final Map<String, DateTime?> visitToTimes = {};
  String? selectedRouteDate;

  CustomerResponse? selectedCustomer;

  int _creationStage = 1;

  int get creationStage => _creationStage;

  void chooseDefaultRegion() {
    if (_regions.isNotEmpty) {
      selectedRegionId = _regions.first.id;
      loadCustomers(selectedRegionId);
    }
  }

  void nextStage() {
    _creationStage = 2;
    notifyListeners();
    loadLastChecklistsInfo();
  }

  void resetStage() {
    _creationStage = 1;
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
      chooseDefaultRegion();
    });
    loadingOff();
  }

  Future loadCustomers(String? regionId) async {
    selectedRegionId = regionId;
    loadingOn();

    (await executeUseCaseParam<List<CustomerResponse>,
                GetAvailableCustomersParam?>(
            _getAvailableCustomersUseCase,
            GetAvailableCustomersParam(userId, regionId!,
                _route?.routeDate.toIso8601String().split('T').first)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;

      notifyListeners();
    });

    loadingOff();
  }

  Future loadLastChecklistsInfo() async {
    loadingOn();

    _lastChecklists.clear();

    // Удаляем из selectedSubtasks те, которых нет в savedTasks
    selectedSubtasks.removeWhere((subtask) =>
        !savedTasks.values.any((task) => task.subtasks.contains(subtask)));

    for (CustomerResponse customer in selectedCustomers) {
      for (AddressDTO address in customer.addresses ?? []) {
        selectedCustomer = customer;
        (await executeUseCaseParam<List<LastCheckListInfoResponse>,
                    GetAvailableChecklistParam>(
                _getAvailableChecklistsUseCase,
                GetAvailableChecklistParam(address.id!, customer.id!, userId,
                    routeDate:
                        _route?.routeDate.toIso8601String().split('T').first)))
            .doOnSuccess((value) {
          _lastChecklists.addAll(value);
        });
      }
    }
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  void toggleCustomerSelection(CustomerResponse customer) {
    final existingCustomer = selectedCustomers.firstWhereOrNull(
      (e) => e.id == customer.id,
    );

    if (existingCustomer != null) {
      selectedCustomers.remove(existingCustomer);
    } else {
      selectedCustomers.add(customer);
    }
    notifyListeners();
  }

  void toggleSubtaskSelection(SubtaskBody? subtask) {
    if (subtask == null) return;

    // Удаляем или добавляем сабтаск
    if (selectedSubtasks
        .filter((e) => e.deviceId == subtask.deviceId)
        .isNotEmpty) {
      selectedSubtasks.removeWhere((e) =>
          e.deviceId == subtask.deviceId && e.addressId == subtask.addressId);
    } else {
      selectedSubtasks.add(subtask);
    }

    // После любого изменения сабтасков обновляем таск
    updateTask();
  }

  void updateVisitTimeFrom(String customerId, String addressId, String text) {
    visitFromTimes['${customerId}_$addressId'] = parseTime(text);
    calculateCreateOrUpdateRouteButtonState();
  }

  void updateVisitTimeTo(String customerId, String addressId, String text) {
    visitToTimes['${customerId}_$addressId'] = parseTime(text);
    calculateCreateOrUpdateRouteButtonState();
  }

  // функция проверяет, если ли в маршруте уже такая задача, если есть, то запрещаем редактировать поля, иначе разрешаем
  bool canChangeTaskFields(String customerId, String addressId) {
    Task? existTask = _route?.tasks.firstWhereOrNull(
        (e) => e.client.id == customerId && e.address.id == addressId);
    return existTask == null;
  }

  void updateTaskComment(String customerId, String addressId, String text) {
    final key = '${customerId}_$addressId';

    // создаём контроллер, если его ещё нет
    taskComments.putIfAbsent(key, () => TextEditingController());

    // обрезаем текст, если он длиннее 500 символов
    if (text.length > 500) {
      taskComments[key]!.text = text.substring(0, 500);
    } else {
      taskComments[key]!.text = text;
    }
  }

  void updateRouteDate(DateTime date) {
    selectedRouteDate = DateUtil.formatToYYYYMMDD(date);
    calculateCreateOrUpdateRouteButtonState();
  }

  void updateTask() {
    // Очищаем старые таски
    savedTasks.clear();

    // Группируем сабтаски по адресу
    final Map<String, List<SubtaskBody>> subtasksByAddress = {};

    for (final subtask in selectedSubtasks) {
      if (subtask.addressId == null) continue;
      subtasksByAddress.putIfAbsent(subtask.addressId!, () => []).add(subtask);
    }

    // Создаем таски по каждому адресу
    for (final entry in subtasksByAddress.entries) {
      final addressId = entry.key;
      final subtasks = entry.value;

      if (subtasks.isEmpty) continue;

      final customer = selectedCustomers
          .firstWhereOrNull((e) => e.id == subtasks.first.customerId);

      if (customer == null) continue;

      final customerName = customer.name ?? '';
      final customerId = customer.id ?? '';
      final vFrom = visitFromTimes['${customerId}_$addressId'];
      final vTo = visitToTimes['${customerId}_$addressId'];
      final comment = taskComments['${customerId}_$addressId'];

      savedTasks[addressId] = TasksBody(
        name: customerName,
        visitTimeFrom: vFrom,
        visitTimeTo: vTo,
        comment: comment?.text,
        clientId: customerId,
        addressId: addressId,
        subtasks: subtasks,
      );
    }

    calculateCreateOrUpdateRouteButtonState();
  }

  void createRoute() async {
    final RouteBody routeBody = RouteBody(userId, savedTasks.values.toList(),
        routeDate: selectedRouteDate);
    loadingOn();
    (await executeUseCaseParam<void, RouteBody>(_createRouteUseCase, routeBody))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      addAlert(Alert('Маршрут успешно назначен', style: AlertStyle.success));
      selectedSubtasks.clear();
      savedTasks.clear();
      Future.delayed(const Duration(milliseconds: 500), () {
        _router.pushReplacement(RouteName.usersList);
      });
      notifyListeners();
    });
    loadingOff();
  }

  Future updateRoute() async {
    if (_route == null) {
      addAlert(Alert(
          'Ошибка обновления маршрута. Действующий маршрут не найден',
          style: AlertStyle.danger));
    } else {
      for (var entry in savedTasks.entries) {
        final String addressId = entry.key;
        final TasksBody newTask = entry.value;

        Task? existsTask =
            _route?.tasks.firstWhereOrNull((e) => e.address.id == addressId);

        if (existsTask != null) {
          // Convert existing subtasks to SubtaskBody format
          final existingSubtasks = existsTask.subtasks
              .map((subtask) => SubtaskBody(
                    subtask.taskId, // customerId
                    subtask.device.id, // deviceId
                    subtask.comment,
                    subtask.expectedAroma.id, // expectedAromaId
                    subtask.expectedAromaVolume,
                    subtask.volumeFormula ??
                        Constants.aromaFormulasList.last, // volumeFormula
                    subtask.contractType ?? Constants.contractTypesList.first,
                    subtask.subtaskType.id, // typeId
                    id: subtask.id,
                    addressId: subtask.taskId,
                    subtaskStatus: subtask.subtaskStatus,
                  ))
              .toList();

          // Update the task with existing subtasks and new subtasks
          savedTasks[addressId] = newTask.copyWith(
            id: existsTask.id,
            taskStatus: existsTask.taskStatus,
            subtasks: [...existingSubtasks, ...newTask.subtasks],
          );
        }
      }

      final RouteBody routeBody = RouteBody(userId, savedTasks.values.toList(),
          routeId: _route?.id,
          routeStatus: _route?.routeStatus,
          routeDate: selectedRouteDate);
      loadingOn();
      (await executeUseCaseParam<void, RouteBody>(
              _updateRouteUseCase, routeBody))
          .doOnError((message, exception) {
        addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
      }).doOnSuccess((value) {
        addAlert(Alert('Маршрут успешно обновлен', style: AlertStyle.success));
        selectedSubtasks.clear();
        savedTasks.clear();
        Future.delayed(const Duration(milliseconds: 500), () {
          _router.pushReplacement(RouteName.usersList);
        });
        notifyListeners();
      });
      loadingOff();
    }
  }

  Future loadAromas() async {
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

  void loadTaskTypes() async {
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

  Future getUserRoute() async {
    (await executeUseCaseParam<RouteResponse, String>(
            _getRouteByIdUseCase, routeId!))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _route = value;
      updateRouteDate(_route!.routeDate);
      for (var task in _route!.tasks) {
        if (task.visitTimeFrom != null) {
          updateVisitTimeFrom(task.client.id, task.address.id,
              DateFormat(DateFormats.HHmm).format(task.visitTimeFrom!));
        }
        if (task.visitTimeTo != null) {
          updateVisitTimeTo(task.client.id, task.address.id,
              DateFormat(DateFormats.HHmm).format(task.visitTimeTo!));
        }

        updateTaskComment(task.client.id, task.address.id, task.comment ?? '');
      }
    });
  }

  void calculateCreateOrUpdateRouteButtonState() {
    // Базовые проверки на непустые задачи и выбранных клиентов
    if (savedTasks.isEmpty || selectedCustomers.isEmpty) {
      _isCreateOrUpdateRouteButtonEnabled = false;
      notifyListeners();
      return;
    }

    // Собираем ID клиентов из сохранённых задач
    final savedClientIds =
        savedTasks.values.map((task) => task.clientId).toSet();

    // Проверяем, что все выбранные клиенты есть в сохранённых задачах
    final allSelectedClientsExist =
        selectedCustomers.every((c) => savedClientIds.contains(c.id));

    // Проверяем каждую задачу
    bool allTasksValid = true;

    savedTasks.updateAll((_, task) {
      final key = '${task.clientId}_${task.addressId}';
      final visitFrom = visitFromTimes[key];
      final visitTo = visitToTimes[key];

      final isValid = visitFrom != null &&
          visitTo != null &&
          task.subtasks.isNotEmpty &&
          selectedCustomers.any((c) => c.id == task.clientId);

      if (!isValid) {
        allTasksValid = false;
      }

      return task.copyWith(visitTimeFrom: visitFrom, visitTimeTo: visitTo);
    });

    // Объединённая финальная проверка
    _isCreateOrUpdateRouteButtonEnabled =
        allSelectedClientsExist && allTasksValid && selectedRouteDate != null;

    notifyListeners();
  }

  DateTime? parseTime(String timeText) {
    final timeRegex = RegExp(r'^\d{2}:\d{2}$');

    if (!timeRegex.hasMatch(timeText)) return null;

    final timeParts = timeText.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    if (hours > 23 || minutes > 59) return null; // Дополнительная проверка

    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hours, minutes);
  }

  @override
  String get title => routeId != null
      ? 'Редактирование маршрутного листа'
      : 'Создание маршрутного листа';
}
