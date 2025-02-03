import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/inventory_response.dart';
import 'package:feelmeweb/domain/inventory/get_inventory_usecase.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/presentation/base_vm/base_search_view_model.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class InventoryViewModel extends BaseSearchViewModel {
  InventoryViewModel() {
    loadInventory();
  }

  final _getInventoryUseCase = GetInventoryUseCase();

  final _router = getIt<RouteGenerator>().router;

  InventoryResponse? _inventory;

  InventoryResponse? get inventory => _inventory;

  void loadInventory() async {
    loadingOn();
    (await executeUseCase<InventoryResponse>(_getInventoryUseCase))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _inventory = value;
      notifyListeners();
    });
    loadingOff();
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  void toggleCustomerSelection(CustomerResponse customer) {
    notifyListeners();
  }

  void toggleSubtaskSelection(SubtaskBody subtask) {
    notifyListeners();
  }

  @override
  String get title => 'Инвентарь СИ';
}
