import 'package:base_class_gen/core/ext/build_context_ext.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/add_device_body.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/domain/devices/delete_device_usecase.dart';
import 'package:feelmeweb/domain/devices/get_device_models_use_case.dart';
import 'package:feelmeweb/domain/devices/get_device_powers_use_case.dart';
import 'package:feelmeweb/domain/regions/get_regions_usecase.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:flutter/material.dart';
import '../../data/models/request/add_customer_address.dart';
import '../../domain/address/add_address_usecase.dart';
import '../../domain/devices/create_device_usecase.dart';
import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_search_view_model.dart';
import '../../provider/di/di_provider.dart';
import 'widgets/devices_table_dialog_widget.dart';

class CustomersViewModel extends BaseSearchViewModel {
  CustomersViewModel() {
    loadDeviceCatalogs();
    loadCustomers();
  }

  final _getCustomersUseCase = GetCustomersUseCase();
  final _deleteDeviceUseCase = DeleteDeviceUseCase();
  final _getDeviceModelsUseCase = GetDeviceModelsUseCase();
  final _getDevicePowersUseCase = GetDevicePowersUseCase();
  final _addAddressUseCase = AddAddressUseCase();
  final _addDeviceUseCase = CreateDeviceUseCase();
  final _getRegionsUseCase = GetRegionsUseCase();
  final _currentCountDevices = <String, int>{};
  List<DevicePowersResponse> powers = [];
  List<DeviceModelsResponse> models = [];
  List<CustomerResponse> _customers = [];
  List<RegionResponse> regions = [];

  List<CustomerResponse> get customers => _customers;

  final List<DataColumn> _tableCustomersColumns = [
    const DataColumn(
        label: Text('Наименование'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Телефон'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Директор'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Адреса'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(label: Text('')),
  ];

  List<DataColumn> get tableCustomersColumns => _tableCustomersColumns;

  void loadCustomers({String? regionId, bool isLoaderNeeded = true}) async {
    if (isLoaderNeeded) loadingOn();
    (await executeUseCaseParam<List<CustomerResponse>, String?>(
            _getCustomersUseCase, regionId))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _customers = value;
      fillCurrentCountDevices();
      loadingOff();
    });
    _getRegionsUseCase().then((v) {
      v.doOnSuccess((data) {
        regions = data;
      });
    });
  }

  Future<void> addAddress(AddCustomerAddressBody body) async {
    (await executeUseCaseParam(_addAddressUseCase, body))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((_) {
      loadCustomers();
    });
  }

  void fillCurrentCountDevices() {
    for (var e in _customers) {
      if (e.id != null) {
        _currentCountDevices[e.id!] = e.devices?.length ?? 0;
      }
    }
  }

  Future<void> addDevice(AddDeviceBody body, String? customerId) async {
    (await executeUseCaseParam(_addDeviceUseCase, body.copyWith(customerId: customerId)))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      loadCustomers();
    });
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

  List<DataRow> getTableCustomersRows(List<CustomerResponse> customers) =>
      customers.map((customer) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(customer.name ?? ''),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(customer.phone ?? ''),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(customer.ownerName ?? ''),
          )),
          DataCell(IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              final context =
                  getIt<RouteGenerator>().navigatorKey.currentContext;
              if (context == null) return;
              Dialogs.showAddressesDialog(
                getIt<RouteGenerator>().navigatorKey.currentContext,
                customer.addresses ?? [],
                regions,
                addAddress,
                customer.id!,
              );
            },
            tooltip: 'Посмотреть адреса',
          )),
          DataCell(Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.devices),
                  onPressed: () {
                    final context =
                        getIt<RouteGenerator>().navigatorKey.currentContext;
                    if (context == null) return;
                    Dialogs.showBaseDialog(
                            context,
                            DevicesTableDialogWidget(
                                devices: customer.devices ?? [],
                                removeCallback: (s, l) {
                                  deleteDevice(s);
                                  if (customer.id != null) {
                                    _currentCountDevices[customer.id!] = l;
                                  }
                                },
                                powers: powers,
                                models: models,
                                addresses: customer.addresses ?? [],
                                addDeviceCallback: (body) =>
                                    addDevice(body, customer.id)),
                            width: context.currentSize.width * 0.65)
                        .then((_) {
                      if (customer.devices?.length !=
                          _currentCountDevices[customer.id]) {
                        loadCustomers();
                      }
                    });
                  },
                  tooltip: 'Посмотреть оборудование'),
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

  Future<void> loadDeviceCatalogs() async {
    _getDeviceModelsUseCase().then((v) {
      v.doOnSuccess((data) {
        models = data;
      });
    });
    _getDevicePowersUseCase().then((v) {
      v.doOnSuccess((data) {
        powers = data;
      });
    });
  }

  @override
  String get title => 'Клиенты';
}
