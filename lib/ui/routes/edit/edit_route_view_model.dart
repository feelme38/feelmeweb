import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/domain/route/change_route_status_usecase.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/domain/subtasks/delete_subtask_usecase.dart';
import 'package:feelmeweb/domain/tasks/delete_task_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class EditRouteViewModel extends BaseSearchViewModel {
  EditRouteViewModel(this.userId) {
    loadRoute();
  }

  final _getUserRouteUseCase = GetUserRouteUseCase();
  final _deleteTaskUseCase = DeleteTaskUseCase();
  final _deleteSubtaskUseCase = DeleteSubtaskUseCase();
  final _changeRouteStatusUseCase = ChangeRouteStatusUseCase();
  final _getRegionsUseCase = GetRegionsUseCase();
  final _getCustomersUseCase = GetCustomersUseCase();

  final _router = getIt<RouteGenerator>().router;

  final String userId;

  RouteResponse? _route;
  List<RegionResponse> _regions = [];
  List<CustomerResponse> _customers = [];

  RouteResponse? get route => _route;
  List<RegionResponse> get regions => _regions;
  List<CustomerResponse> get customers => _customers;

  int _creationStage = 1;

  int get creationStage => _creationStage;

  void nextStage() {
    _creationStage = 2;
    notifyListeners();
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
      (await executeUseCaseParam<List<CustomerResponse>, String?>(
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

            // Проверяем каждый адрес клиента
            for (var address in customerAddresses) {
              bool hasMatchingSubtask = false;

              // Проверяем каждую задачу клиента
              for (var task in customerTasks) {
                // Проверяем каждую подзадачу в задаче
                for (var subtask in task.subtasks) {
                  // Если адрес подзадачи совпадает с адресом клиента
                  if (subtask.checklist?.address?.id == address.id) {
                    hasMatchingSubtask = true;
                    break;
                  }
                }
                if (hasMatchingSubtask) break;
              }

              // Если хотя бы один адрес не имеет соответствующей подзадачи, показываем регион
              if (!hasMatchingSubtask) {
                return true;
              }
            }
          }

          // Если все адреса всех клиентов имеют соответствующие подзадачи, не показываем регион
          return false;
        }).toList();

        notifyListeners();
      });
    });
    loadingOff();
  }

  Future loadRoute() async {
    loadingOn();
    (await executeUseCaseParam<RouteResponse, GetUserRouteParam>(
            _getUserRouteUseCase, GetUserRouteParam(userId)))
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
          Alert('Пользователь снят с мааршрута', style: AlertStyle.success));
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

  @override
  String get title => 'Редактирование маршрутного листа';
}
