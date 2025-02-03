import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
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

  final _router = getIt<RouteGenerator>().router;

  final String userId;

  RouteResponse? _route;

  RouteResponse? get route => _route;

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
