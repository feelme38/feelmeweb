import 'package:feelmeweb/core/date_utils.dart';
import 'package:feelmeweb/data/models/response/pagination_routes_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/route/get_filtered_routes_usecase.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';

class RoutesHistoryViewModel extends BaseSearchViewModel {
  RoutesHistoryViewModel() {
    Future.microtask(() async {
      loadingOn();
      await loadRoutes(refresh: false);
      await loadUsers();
      loadingOff();
    });
  }

  final _getFilterRoutesUseCase = GetFilterRoutesUseCase();
  final _getUsersUseCase = GetUsersUseCase();

  List<RouteResponse> _routes = [];
  List<RouteResponse> _filteredRoutes = [];
  PaginationRoutesResponse? _paginationRoutes;
  List<UserResponse> _users = [];
  int _currentPage = 1;
  String? _selectedStatus;
  DateTime? _selectedDate;
  UserResponse? _selectedUser;
  RouteResponse? _routeResponse;

  List<RouteResponse> get routes => _filteredRoutes;
  PaginationRoutesResponse? get paginationRoutes => _paginationRoutes;
  List<UserResponse> get users => _users;
  int get currentPage => _currentPage;
  String? get selectedStatus => _selectedStatus;
  DateTime? get selectedDate => _selectedDate;
  UserResponse? get selectedUser => _selectedUser;
  RouteResponse? get selectedRoute => _routeResponse;

  @protected
  BuildContext? get navigatorContext =>
      getIt<RouteGenerator>().navigatorKey.currentContext;

  Future<void> loadRoutes({bool refresh = true}) async {
    selectRoute(null);
    if (refresh) loadingOn();
    (await executeUseCaseParam<PaginationRoutesResponse,
            GetFilteredRoutesParam>(
      _getFilterRoutesUseCase,
      GetFilteredRoutesParam(
          userId: selectedUser?.id,
          assignDate: _selectedDate != null
              ? DateUtil.formatToYYYYMMDD(_selectedDate!)
              : null,
          routeStatus: _selectedStatus,
          page: _currentPage,
          pageSize: 1),
    ))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _paginationRoutes = value;
      _routes = _paginationRoutes!.data;
      _filteredRoutes = _routes;
      notifyListeners();
    });
    if (refresh) loadingOff();
  }

  Future<void> loadUsers() async {
    (await executeUseCaseParam<List<UserResponse>, String?>(
            _getUsersUseCase, 'd73285b5-dd1a-43a4-8c04-4cb65f62af3a'))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      notifyListeners();
    });
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

  void filterByStatus(String? status) {
    _selectedStatus = status;
    loadRoutes();
  }

  void filterByDate(DateTime? date) {
    _selectedDate = date;
    loadRoutes();
  }

  void filterByUser(UserResponse? user) {
    _selectedUser = user;
    loadRoutes();
  }

  void changePage(page) {
    if (page > 0 && page <= paginationRoutes?.meta.totalPages) {
      _currentPage = page;
      loadRoutes();
    }
  }

  void selectRoute(RouteResponse? route) {
    if (_routeResponse == route) {
      _routeResponse = null;
    } else {
      _routeResponse = route;
    }
    notifyListeners();
  }

  @override
  String get title => 'Маршруты';
}
