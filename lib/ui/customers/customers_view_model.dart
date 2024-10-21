import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/devices/delete_device_usecase.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:flutter/material.dart';
import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_search_view_model.dart';
import '../../provider/di/di_provider.dart';
import 'widgets/devices_table_dialog_widget.dart';

class CustomersViewModel extends BaseSearchViewModel {

  CustomersViewModel() {
    loadCustomers();
  }

  final _getCustomersUseCase = GetCustomersUseCase();
  final _deleteDeviceUseCase = DeleteDeviceUseCase();
  final _currentCountDevices = <String, int>{};
  List<CustomerResponse> _customers = [];
  List<CustomerResponse> get customers => _customers;

  final List<DataColumn> _tableCustomersColumns = [
    const DataColumn(
        label: Text('Наименование'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Телефон'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Директор'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Вр. посещения'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Адрес'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(label: Text('')),
  ];

  List<DataColumn> get tableCustomersColumns => _tableCustomersColumns;

  void loadCustomers({String? regionId, bool isLoaderNeeded = true}) async {
    if(isLoaderNeeded) loadingOn();
    (await executeUseCaseParam<List<CustomerResponse>, String?>(_getCustomersUseCase, regionId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;
      fillCurrentCountDevices();
      notifyListeners();
    });
    if(isLoaderNeeded) loadingOff();
  }

  void fillCurrentCountDevices() {
    for (var e in _customers) {
      _currentCountDevices[e.id] = e.devices.length;
    }
  }

  void deleteDevice(String deviceId) async {
    (await executeUseCaseParam<void, String>(_deleteDeviceUseCase, deviceId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    });
  }

  void onSearch(String? text) {
    clearEnabled = text != null && text.isNotEmpty;
    //refilter(state.defects);
  }

  List<DataRow> getTableCustomersRows(List<CustomerResponse> customers) => customers.map((customer) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(customer.name),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(customer.phone),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(customer.ownerName),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(customer.preferredStartTime),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(customer.address),
          )
      ),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.devices),
            onPressed: () {
              final context = getIt<RouteGenerator>().navigatorKey.currentContext;
              if (context == null) return;
              Dialogs.showBaseDialog(
                  context,
                  DevicesTableDialogWidget(devices: customer.devices, removeCallback: (s, l) {
                    deleteDevice(s);
                    _currentCountDevices[customer.id] = l;
                  })
              ).then((_) {
                if(customer.devices.length != _currentCountDevices[customer.id]) {
                  loadCustomers();
                }
              });
            },
            tooltip: 'Посмотреть оборудование',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Логика редактирования пользователя
            },
            tooltip: 'Редактировать',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Логика удаления пользователя
            },
            tooltip: 'Удалить',
          ),
        ],
      )),
    ]);
  }).toList();

  @override
  String get title => 'Клиенты';
}