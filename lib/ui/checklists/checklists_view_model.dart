import 'package:feelmeweb/core/date_utils.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/checklists/get_filtered_checklists_usecase.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../presentation/alert/alert.dart';

class ChecklistsViewModel extends BaseSearchViewModel {
  ChecklistsViewModel() {
    Future.microtask(() async {
      loadingOn();
      await loadCustomers();
      await loadEngineers();
      await loadChecklists(refresh: false);
      loadingOff();
    });
  }

  final _getCustomersUseCase = GetCustomersUseCase();
  final _getUsersUseCase = GetUsersUseCase();
  final _getFilterChecklistsUseCase = GetFilterChecklistsUseCase();

  List<UserResponse> _users = [];
  List<UserResponse> get users => _users;

  List<CustomerResponse> _customers = [];
  List<CustomerResponse> get customers => _customers;

  List<ChecklistResponseItem> _checklists = [];
  List<ChecklistResponseItem> _filteredChecklists = [];
  PaginationChecklistsResponse? _paginationChecklists;

  List<ChecklistResponseItem> get checklists => _filteredChecklists;
  PaginationChecklistsResponse? get paginationChecklists =>
      _paginationChecklists;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  String? selectedCustomerId;
  UserResponse? _selectedEngineer;
  UserResponse? get selectedEngineer => _selectedEngineer;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  ChecklistResponseItem? _selectedChecklist;
  ChecklistResponseItem? get selectedChecklist => _selectedChecklist;

  void chooseCustomer(String userId) {
    selectedCustomerId = userId;
    _currentPage = 1; // Reset to first page when changing customer
    loadChecklists();
  }

  void filterByEngineer(UserResponse? engineer) {
    _selectedEngineer = engineer;
    _currentPage = 1; // Reset to first page when changing filter
    loadChecklists();
  }

  void filterByDate(DateTime? date) {
    _selectedDate = date;
    _currentPage = 1; // Reset to first page when changing filter
    loadChecklists();
  }

  void changePage(int page) {
    if (page >= 1 && page <= (_paginationChecklists?.meta?.totalPages ?? 1)) {
      _currentPage = page;
      loadChecklists();
    }
  }

  Future loadCustomers() async {
    (await executeUseCaseParam<List<CustomerResponse>, String?>(
            _getCustomersUseCase, null))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;
      if (_customers.isNotEmpty) selectedCustomerId = _customers.first.id;
      notifyListeners();
    });
  }

  Future loadEngineers() async {
    (await executeUseCaseParam<List<UserResponse>, String?>(
            _getUsersUseCase, 'd73285b5-dd1a-43a4-8c04-4cb65f62af3a'))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      notifyListeners();
    });
  }

  Future<void> loadChecklists({bool refresh = true}) async {
    _selectedChecklist = null;
    if (refresh) loadingOn();

    final engineerId = _selectedEngineer?.id;
    final dateFilter = _selectedDate != null
        ? DateUtil.formatToYYYYMMDD(_selectedDate!)
        : null;

    (await executeUseCaseParam<PaginationChecklistsResponse,
            GetFilteredChecklistsParam>(
      _getFilterChecklistsUseCase,
      GetFilteredChecklistsParam(
          customerId: selectedCustomerId!,
          engineerId: engineerId,
          createdDate: dateFilter,
          page: _currentPage,
          pageSize: 15),
    ))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _paginationChecklists = value;
      _checklists = _paginationChecklists!.data!;
      _filteredChecklists = _checklists;
      notifyListeners();
    });
    if (refresh) loadingOff();
  }

  void onSearch(String? text) {
    /*clearEnabled = text != null && text.isNotEmpty;
    if (text == null || text.isEmpty) {
      _filteredChecklists = _checklists;
    } else {
      _filteredChecklists = _checklists
          .where((checklist) => checklist.task.client.name
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }*/
    notifyListeners();
  }

  void onChecklistSelected(ChecklistResponseItem? checklist) {
    if (_selectedChecklist == checklist) {
      _selectedChecklist = null;
    } else {
      _selectedChecklist = checklist;
    }
    notifyListeners();
  }

  @override
  String get title => 'Чек-листы';
}
