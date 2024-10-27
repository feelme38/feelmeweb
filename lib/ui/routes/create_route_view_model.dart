import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';

import '../../data/models/response/customer_response.dart';
import '../../domain/customers/get_customers_usecase.dart';
import '../../presentation/alert/alert.dart';

class CreateRouteViewModel extends BaseSearchViewModel {

  CreateRouteViewModel() {
    loadRegions();
  }

  final _getRegionsUseCase = GetRegionsUseCase();
  final _getCustomersUseCase = GetCustomersUseCase();

  List<RegionResponse> _regions = [];
  List<RegionResponse> get regions => _regions;

  List<CustomerResponse> _customers = [];
  List<CustomerResponse> get customers => _customers;

  String? selectedRegionId;
  final List<String> selectedCustomersIds = [];

  void chooseDefaultRegion() {
    if (_regions.isNotEmpty) {
      selectedRegionId = _regions.first.id;
      loadCustomers(regionId: selectedRegionId);
    }
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

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  void toggleCustomerSelection(String customerId) {
    if (selectedCustomersIds.contains(customerId)) {
      selectedCustomersIds.remove(customerId);
    } else {
      selectedCustomersIds.add(customerId);
    }
    notifyListeners();
  }

  @override
  String get title => 'Выберите клиентов на сегодня';
}