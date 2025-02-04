import 'package:collection/collection.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/list_ext.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/request/tasks_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_last_checklists_usecase.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/domain/route/create_route_usecase.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/domain/route/update_route_usecase.dart';
import 'package:feelmeweb/domain/tasks/get_task_types_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';

class CreateRouteViewModel extends BaseSearchViewModel {
  CreateRouteViewModel(this.userId, this.isUpdate) {
    if (isUpdate) {
      getUserRoute();
    }
    loadRegions();
    loadAromas();
    loadTaskTypes();
  }

  final _getRegionsUseCase = GetRegionsUseCase();
  final _getCustomersUseCase = GetCustomersUseCase();
  final _getLastChecklistsUseCase = GetLastChecklistsUseCase();
  final _getAromasUseCase = GetAromasUseCase();
  final _getTaskTypesUseCase = GetTaskTypesUseCase();
  final _createRouteUseCase = CreateRouteUseCase();
  final _updateRouteUseCase = UpdateRouteUseCase();
  final _getUserRouteUseCase = GetUserRouteUseCase();

  final _router = getIt<RouteGenerator>().router;

  final String userId;
  final bool isUpdate;

  List<RegionResponse> _regions = [];

  List<RegionResponse> get regions => _regions;

  List<CustomerResponse> _customers = [];

  List<CustomerResponse> get customers => _customers;

  List<LastCheckListInfoResponse> _lastChecklists = [];

  List<LastCheckListInfoResponse> get lastChecklists => _lastChecklists;

  List<AromaResponse> _aromas = [];

  List<AromaResponse> get aromas => _aromas;

  List<TaskTypeResponse> _taskTypes = [];

  List<TaskTypeResponse> get taskTypes => _taskTypes;
  TaskTypeResponse? selectedTaskType;

  String? selectedRegionId;
  String? selectedCustomerId;
  String? selectedAddressId;
  final List<CustomerResponse> selectedCustomers = [];
  final List<SubtaskBody> selectedSubtasks = [];
  final Map<String, TasksBody> savedTasks = {};
  final TextEditingController visitTimeController = TextEditingController();

  CustomerResponse? selectedCustomer;

  int _creationStage = 1;

  int get creationStage => _creationStage;

  void chooseDefaultRegion() {
    if (_regions.isNotEmpty) {
      selectedRegionId = _regions.first.id;
      loadCustomers(regionId: selectedRegionId);
    }
  }

  void chooseDefaultCustomer() {
    if (selectedCustomers.isNotEmpty) {
      selectedCustomerId = selectedCustomers.first.id;
      selectedAddressId = selectedCustomers.first.addresses?.firstOrNull?.id;
      loadLastChecklistsInfo(
          customer: selectedCustomers.first, addressId: selectedAddressId);
    }
  }

  void nextStage() {
    _creationStage = 2;
    notifyListeners();
    chooseDefaultCustomer();
  }

  void resetStage() {
    _creationStage = 1;
    notifyListeners();
  }

  void selectNewTaskType(TaskTypeResponse? taskType) {
    selectedTaskType = taskType;
    notifyListeners();
  }

  void loadRegions() async {
    loadingOn();
    (await executeUseCase<List<RegionResponse>>(_getRegionsUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _regions = value;
      chooseDefaultRegion();
      notifyListeners();
    });
    loadingOff();
  }

  void loadCustomers({String? regionId}) async {
    selectedRegionId = regionId;
    loadingOn();
    (await executeUseCaseParam<List<CustomerResponse>, String?>(
            _getCustomersUseCase, regionId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;
      notifyListeners();
    });
    loadingOff();
  }

  void loadLastChecklistsInfo(
      {CustomerResponse? customer, String? addressId}) async {
    if (customer == null) return;
    if (customer.id == null) return;
    loadingOn();

    // Удаляем из selectedSubtasks те, которых нет в savedTasks
    selectedSubtasks.removeWhere((subtask) =>
        !savedTasks.values.any((task) => task.subtasks.contains(subtask)));

    visitTimeController.clear();
    selectNewTaskType(taskTypes.first);
    selectedCustomerId = customer.id;
    selectedCustomer = customer;

    (await executeUseCaseParam<List<LastCheckListInfoResponse>,
                GetLastChecklistParam>(_getLastChecklistsUseCase,
            GetLastChecklistParam(addressId!, customer.id!)))
        .doOnSuccess((value) {
      selectedAddressId = addressId;
      _lastChecklists = value;
      loadingOff();
    });
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  void toggleCustomerSelection(CustomerResponse customer) {
    if (selectedCustomers.contains(customer)) {
      selectedCustomers.remove(customer);
    } else {
      selectedCustomers.add(customer);
    }
    notifyListeners();
  }

  void toggleSubtaskSelection(SubtaskBody subtask) {
    if (selectedSubtasks
        .filter((e) => e.deviceId == subtask.deviceId)
        .isNotEmpty) {
      selectedSubtasks.removeWhere((e) => e.deviceId == subtask.deviceId);
      if (selectedSubtasks.isEmpty) savedTasks.remove(selectedAddressId);
    } else {
      selectedSubtasks.add(subtask.copyWith(addressId: selectedAddressId));
    }
    notifyListeners();
  }

  void addTask() {
    final DateTime? visitTime = parseTime(visitTimeController.text);
    final String? typeId = selectedTaskType?.id;
    final String? customerName = selectedCustomer?.name;
    final String? customerId = selectedCustomerId;
    final String? addressId = selectedAddressId;
    final List<SubtaskBody> subtasks = selectedSubtasks.filter(
        (e) => e.customerId == selectedCustomerId && e.addressId == addressId);
    if (visitTime == null ||
        typeId == null ||
        customerName == null ||
        customerId == null ||
        addressId == null ||
        subtasks.isEmpty) return;
    final TasksBody taskBody = TasksBody(
        customerName, visitTime, typeId, customerId, addressId, subtasks);
    savedTasks[addressId] = taskBody;
    addAlert(Alert('Задание успешно сохранено', style: AlertStyle.success));
    notifyListeners();
  }

  void createRoute() async {
    final RouteBody routeBody = RouteBody(userId, savedTasks.values.toList());
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
    loadingOn();
    final route = await getUserRoute();
    if (route == null) {
      addAlert(Alert(
          'Ошибка обновления маршрута. Действующий маршрут не найден',
          style: AlertStyle.danger));
    } else {
      for (var entry in savedTasks.entries) {
        final String addressId = entry.key;
        final TasksBody newTask = entry.value;

        Task? existsTask =
            route.tasks.firstWhereOrNull((e) => e.address.id == addressId);

        if (existsTask != null) {
          // Обновляем newTask, присваивая новый объект
          savedTasks[addressId] = newTask.copyWith(
            id: existsTask.id,
            subtasks: [
              ...existsTask.subtasks.map(
                (subtask) => SubtaskBody(
                  id: subtask.id,
                  newTask.clientId,
                  subtask.device.id,
                  subtask.comment,
                  subtask.expectedAroma.id,
                  subtask.expectedAromaVolume,
                  subtask.estimatedCompletedTime,
                ),
              ),
              ...newTask.subtasks, // Сохраняем старые подзадачи
            ],
          );
        }
      }

      // Добавляем существующие таски, если их нет в savedTasks
      for (var task in route.tasks) {
        if (!savedTasks.containsKey(task.address.id)) {
          savedTasks[task.address.id] = TasksBody(
            task.client.name,
            DateTime.now(),
            task.taskType.id,
            task.client.id,
            task.address.id,
            task.subtasks
                .map(
                  (subtask) => SubtaskBody(
                    task.client.id,
                    subtask.device.id,
                    subtask.comment,
                    subtask.expectedAroma.id,
                    subtask.expectedAromaVolume,
                    subtask.estimatedCompletedTime,
                  ),
                )
                .toList(),
          );
        }
      }

      final RouteBody routeBody =
          RouteBody(routeId: route.id, userId, savedTasks.values.toList());

      (await executeUseCaseParam<void, RouteBody>(
              _updateRouteUseCase, routeBody))
          .doOnError((message, exception) {
        addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
      }).doOnSuccess((value) {
        addAlert(Alert('Маршрут успешно обновлён', style: AlertStyle.success));
        selectedSubtasks.clear();
        savedTasks.clear();
        Future.delayed(const Duration(milliseconds: 500), () {
          // Перейти на customerEditRoute
          _router.pushReplacement(RouteName.customerEditRoute, extra: userId);
        });
        notifyListeners();
      });
    }

    loadingOff();
  }

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

  void loadTaskTypes() async {
    loadingOn();
    (await executeUseCase<List<TaskTypeResponse>>(_getTaskTypesUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _taskTypes = value;
      selectedTaskType = (value as List<TaskTypeResponse>).firstOrNull;
      notifyListeners();
    });
    loadingOff();
  }

  Future<RouteResponse?> getUserRoute() async {
    RouteResponse? route;

    (await executeUseCaseParam<RouteResponse, GetUserRouteParam>(
            _getUserRouteUseCase, GetUserRouteParam(userId)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      route = value;
    });
    return route;
  }

  void updateVisitTime() {
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
  String get title => isUpdate
      ? 'Редактирование маршрутного листа'
      : 'Создание маршрутного листа';
}
