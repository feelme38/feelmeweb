import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../presentation/alert/alert.dart';

class RouteInfoViewModel extends BaseSearchViewModel {
  RouteInfoViewModel(this.userId) {
    loadRoute();
  }

  final _getUserRouteUseCase = GetUserRouteUseCase();

  final String userId;

  RouteResponse? _route;

  RouteResponse? get route => _route;

  late Client selectedCustomer;

  void chooseCustomer(Client customer) {
    selectedCustomer = customer;
    notifyListeners();
  }

  Future loadRoute() async {
    loadingOn();
    (await executeUseCaseParam<RouteResponse, GetUserRouteParam>(
            _getUserRouteUseCase, GetUserRouteParam(userId)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _route = (value as RouteResponse);
      selectedCustomer = _route!.tasks.first.client;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  @override
  String get title => 'Информация о текущем маршруте';
}
