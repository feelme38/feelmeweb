import 'package:feelmeweb/core/extensions/base_class_extensions/list_ext.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/request/tasks_body.dart';
import 'package:feelmeweb/data/models/response/checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/domain/checklists/get_last_checklists_usecase.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/domain/route/create_route_usecase.dart';
import 'package:feelmeweb/domain/tasks/get_task_types_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';

import '../../data/models/response/aroma_response.dart';
import '../../data/models/response/customer_response.dart';
import '../../domain/aromas/get_aromas_usecase.dart';
import '../../domain/customers/get_customers_usecase.dart';
import '../../presentation/alert/alert.dart';
import '../../provider/di/di_provider.dart';

class CreateRouteViewModel extends BaseSearchViewModel {
  CreateRouteViewModel(this.userId) {
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

  final _router = getIt<RouteGenerator>().router;

  final String userId;

  List<RegionResponse> _regions = [];

  List<RegionResponse> get regions => _regions;

  List<CustomerResponse> _customers = [];

  List<CustomerResponse> get customers => _customers;

  List<CheckListInfoResponse> _lastChecklists = [];

  List<CheckListInfoResponse> get lastChecklists => _lastChecklists;

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
    selectedCustomerId = customer.id;
    selectedCustomer = customer;
    selectedAddressId = addressId;
    notifyListeners();
    (await executeUseCaseParam<List<CheckListInfoResponse>,
                GetLastChecklistParam>(_getLastChecklistsUseCase,
            GetLastChecklistParam(selectedAddressId!, customer.id!)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _lastChecklists = value;
      notifyListeners();
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
      if (selectedSubtasks.isEmpty) savedTasks.remove(selectedCustomerId);
    } else {
      selectedSubtasks.add(subtask);
    }
    notifyListeners();
  }

  void addTask() {
    final String? typeId = selectedTaskType?.id;
    final String? customerName = selectedCustomer?.name;
    final String? customerId = selectedCustomerId;
    final List<SubtaskBody> subtasks =
        selectedSubtasks.filter((e) => e.customerId == selectedCustomerId);
    if (typeId == null ||
        customerName == null ||
        customerId == null ||
        subtasks.isEmpty) return;
    final TasksBody taskBody =
        TasksBody(customerName, typeId, customerId, subtasks);
    savedTasks[customerId] = taskBody;
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

  @override
  String get title => 'Создание маршрутного листа';
}
