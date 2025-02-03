import 'package:feelmeweb/data/models/response/active_customer_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/customers/get_active_customers_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../presentation/alert/alert.dart';

class RouteInfoViewModel extends BaseSearchViewModel {
  RouteInfoViewModel(this.userId) {
    loadActiveCustomers();
  }

  final _getActiveCustomersUseCase = GetActiveCustomersUseCase();

  final String userId;

  List<ActiveCustomerResponse> _activeCustomers = [];

  List<ActiveCustomerResponse> get activeCustomers => _activeCustomers;

  late Client selectedCustomer;

  void chooseCustomer(Client customer) {
    selectedCustomer = customer;
    notifyListeners();
  }

  Future loadActiveCustomers() async {
    loadingOn();
    (await executeUseCaseParam<List<ActiveCustomerResponse>, String>(
            _getActiveCustomersUseCase, userId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _activeCustomers = value;
      selectedCustomer = _activeCustomers.first.customer;
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
