import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../data/models/response/customer_response.dart';
import '../../domain/customers/get_customers_usecase.dart';
import '../../presentation/alert/alert.dart';

class CreateRouteViewModel extends BaseSearchViewModel {

  CreateRouteViewModel(this.userId) {
    loadRegions();
  }

  final _getRegionsUseCase = GetRegionsUseCase();
  final _getCustomersUseCase = GetCustomersUseCase();

  final String userId;

  List<RegionResponse> _regions = [];
  List<RegionResponse> get regions => _regions;

  List<CustomerResponse> _customers = [];
  List<CustomerResponse> get customers => _customers;

  String? selectedRegionId;
  String? selectedCustomerId;

  final List<CustomerResponse> selectedCustomers = [];

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
      loadLastChecklistsInfo(customerId: selectedCustomerId);
    }
  }

  void nextStage() {
    _creationStage = 2;
    notifyListeners();
  }

  void resetStage() {
    _creationStage = 1;
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
    (await executeUseCaseParam<List<CustomerResponse>, String?>(_getCustomersUseCase, regionId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;
      notifyListeners();
    });
    loadingOff();
  }

  void loadLastChecklistsInfo({String? customerId}) async {
    selectedCustomerId = customerId;
    loadingOn();
    // (await executeUseCaseParam<List<CustomerResponse>, String?>(_getCustomersUseCase, regionId))
    //     .doOnError((message, exception) {
    //   addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    // }).doOnSuccess((value) {
    //   _customers = value;
    //   notifyListeners();
    // });
    loadingOff();
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

  @override
  String get title => 'Создание маршрутного листа';
}