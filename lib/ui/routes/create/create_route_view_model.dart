import 'package:collection/collection.dart';
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
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/domain/aromas/get_aromas_usecase.dart';
import 'package:feelmeweb/domain/checklists/get_last_checklists_usecase.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/domain/route/create_route_usecase.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/domain/route/update_route_usecase.dart';
import 'package:feelmeweb/domain/subtasks/get_subtask_types_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

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
  final _getSubtaskTypesUseCase = GetSubtaskTypesUseCase();
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
  final Map<String, DateTime?> visitTimes = {};

  CustomerResponse? selectedCustomer;

  int _creationStage = 1;

  int get creationStage => _creationStage;

  void chooseDefaultRegion() {
    if (_regions.isNotEmpty) {
      selectedRegionId = _regions.first.id;
      loadCustomers(regionId: selectedRegionId);
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
    (await executeUseCase<List<RegionResponse>>(_getRegionsUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) async {
      _regions = value;

      // Загружаем всех клиентов
      /*(await executeUseCaseParam<List<CustomerResponse>, String?>(
              _getCustomersUseCase, null))
          .doOnSuccess((customers) {
        _customers = customers;

        // Фильтруем регионы
        _regions = _regions.where((region) {
          // Получаем всех клиентов в регионе
          final regionCustomers = _customers
              .where((customer) => customer.region.id == region.id)
              .toList();

          // Если в регионе нет клиентов, не показываем его
          if (regionCustomers.isEmpty) return false;

          // Проверяем каждый клиент в регионе
          for (var customer in regionCustomers) {
            // Получаем все адреса клиента
            final customerAddresses = customer.addresses ?? [];

            // Если у клиента нет адресов, пропускаем
            if (customerAddresses.isEmpty) continue;

            // Получаем все задачи для этого клиента
            final customerTasks = _route?.tasks
                    .where((task) => task.client.id == customer.id)
                    .toList() ??
                [];

            // Если нет задач для клиента, показываем регион
            if (customerTasks.isEmpty) return true;

            bool hasMatchingSubtask = customerTasks
                .map((e) => e.address.id)
                .toList()
                .every((e) => customerAddresses
                    .map((address) => address.id)
                    .toList()
                    .contains(e));

            return !hasMatchingSubtask;
          }

          // Если все адреса всех клиентов имеют соответствующие подзадачи, не показываем регион
          return false;
        }).toList();
        chooseDefaultRegion();
      });*/
      chooseDefaultRegion();
    });
    loadingOff();
  }

  Future loadCustomers(
      {String? regionId, bool isNeedUpdateState = true}) async {
    selectedRegionId = regionId;
    if (isNeedUpdateState) loadingOn();

    (await executeUseCaseParam<List<CustomerResponse>, String?>(
            _getCustomersUseCase, regionId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      final tasksAddressIds =
          _route?.tasks.map((task) => task.address.id).toSet() ?? {};

      var loadedCustomers = (value as List<CustomerResponse>)
          .where((e) =>
              (e.addresses ?? []).isNotEmpty && (e.devices ?? []).isNotEmpty)
          .toList();

      /*if (isUpdate) {
        for (final customer in loadedCustomers) {
          customer.copyWith(
              addresses: (customer.addresses ?? [])
                  .where((addr) => !tasksAddressIds.contains(addr.id))
                  .toList());
        }

        // Убираем клиентов, у которых после фильтрации не осталось адресов
        loadedCustomers = loadedCustomers
            .where((e) => (e.addresses ?? []).isNotEmpty)
            .toList();
      }*/

      _customers = loadedCustomers;

      if (isNeedUpdateState) notifyListeners();
    });

    if (isNeedUpdateState) loadingOff();
  }

  Future loadLastChecklistsInfo() async {
    loadingOn();

    // Удаляем из selectedSubtasks те, которых нет в savedTasks
    selectedSubtasks.removeWhere((subtask) =>
        !savedTasks.values.any((task) => task.subtasks.contains(subtask)));

    for (CustomerResponse customer in selectedCustomers) {
      for (AddressDTO address in customer.addresses ?? []) {
        selectedCustomer = customer;
        (await executeUseCaseParam<List<LastCheckListInfoResponse>,
                    GetLastChecklistParam>(_getLastChecklistsUseCase,
                GetLastChecklistParam(address.id!, customer.id!)))
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

  void updateVisitTimeForAddress(
      String customerId, String addressId, String timeText) {
    final time = parseTime(timeText);
    visitTimes['${customerId}_$addressId'] = time;
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
      final visitTime = visitTimes['${customerId}_$addressId'];

      savedTasks[addressId] = TasksBody(
        name: customerName,
        visitDateTime: visitTime,
        clientId: customerId,
        addressId: addressId,
        subtasks: subtasks,
      );
    }

    calculateCreateOrUpdateRouteButtonState();
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
                    subtask.volumeFormula ?? '+100',
                    subtask.subtaskType.id),
              ),
              ...newTask.subtasks, // Сохраняем старые подзадачи
            ],
          );
        }
      }

      // Добавляем существующие таски, если их нет в savedTasks
      for (Task task in route?.tasks ?? []) {
        if (!savedTasks.containsKey(task.address.id)) {
          savedTasks[task.address.id] = TasksBody(
            id: task.id,
            name: task.client.name,
            visitDateTime: task.visitDateTime ?? DateTime.now(),
            clientId: task.client.id,
            addressId: task.address.id,
            subtasks: task.subtasks
                .map(
                  (subtask) => SubtaskBody(
                      id: subtask.id,
                      task.client.id,
                      subtask.device.id,
                      subtask.comment,
                      subtask.expectedAroma.id,
                      subtask.expectedAromaVolume,
                      subtask.volumeFormula ?? '+100',
                      subtask.subtaskType.id),
                )
                .toList(),
          );
        }
      }

      final RouteBody routeBody =
          RouteBody(routeId: route?.id, userId, savedTasks.values.toList());

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
    (await executeUseCaseParam<RouteResponse, GetUserRouteParam>(
            _getUserRouteUseCase, GetUserRouteParam(userId)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _route = value;
    });
  }

  void calculateCreateOrUpdateRouteButtonState() {
    final isEveryTaskCreated = selectedCustomers.every(
      (customer) => savedTasks.values
          .map((e) => e.clientId)
          .toList()
          .contains(customer.id),
    );

    final isEveryTaskHasTime = savedTasks.values.every(
      (task) => visitTimes['${task.clientId}_${task.addressId}'] != null,
    );

    _isCreateOrUpdateRouteButtonEnabled =
        isEveryTaskCreated && isEveryTaskHasTime;

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
