import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class RouteListViewModel extends BaseSearchViewModel {
  RouteListViewModel(this.userId) {
    loadRoutes();
  }

  final String userId;

  final _getUserRoutesUseCase = GetUserRoutesUseCase();

  List<RouteResponse> _routes = [];
  List<RouteResponse> _filteredRoutes = [];

  List<RouteResponse> get routes => _filteredRoutes;

  @protected
  BuildContext? get navigatorContext =>
      getIt<RouteGenerator>().navigatorKey.currentContext;

  void openEditRoute(DateTime routeDate) {
    final context = navigatorContext;
    if (context == null) return;
    context.go(
      RouteName.customerEditRoute,
      extra: {
        'userId': userId,
        'routeDate': DateFormat('yyyy-MM-dd').format(routeDate),
      },
    );
  }

  Future<void> loadRoutes() async {
    loadingOn();
    (await executeUseCaseParam<List<RouteResponse>, String>(
            _getUserRoutesUseCase, userId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _routes = value;
      _filteredRoutes = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    if (text == null || text.isEmpty) {
      _filteredRoutes = _routes;
    } else {
      final query = text.toLowerCase();
      _filteredRoutes = _routes.where((r) {
        final name = r.tasks.isNotEmpty ? r.tasks.first.name : '';
        final address = r.tasks.isNotEmpty ? r.tasks.first.address.address : '';
        return name.toLowerCase().contains(query) ||
            address.toLowerCase().contains(query) ||
            r.routeStatus.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  @override
  String get title => 'Маршруты';
}


