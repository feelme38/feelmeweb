import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/device_response.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:feelmeweb/presentation/modals/bottom_modals.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_search_view_model.dart';
import '../../provider/di/di_provider.dart';

class CustomersViewModel extends BaseSearchViewModel {

  CustomersViewModel() {
    loadCustomers();
  }

  final _getCustomersUseCase = GetCustomersUseCase();

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

  final List<DataColumn> _tableCustomerDevicesColumns = [
    const DataColumn(
        label: Text('Модель'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Аромат'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Остаток аромата'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Тип питания'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(
        label: Text('Тип сотрудничества'),
        headingRowAlignment: MainAxisAlignment.center
    ),
    const DataColumn(label: Text('')),
  ];

  List<DataColumn> get tableCustomersColumns => _tableCustomersColumns;

  void loadCustomers({String? regionId}) async {
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
                  IntrinsicHeight(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0), // Внутренние отступы
                      child: AppTableWidget(
                          dataColumns: _tableCustomerDevicesColumns,
                          dataRows: _getTableCustomerDevicesRows(customer.devices)
                      ),
                    ),
                  )
              );
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

  List<DataRow> _getTableCustomerDevicesRows(List<DeviceResponse> devices) => devices.map((device) {
    return DataRow(cells: [
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(device.model.orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text((device.aroma?.name).orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text((device.aromaVolume?.toString()).orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(device.powerType.orDash()),
          )
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(device.contract.orDash()),
          )
      ),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              devices.removeWhere((e) => e.id == device.id);
              notifyListeners();
              // Логика удаления пользователя
            },
            tooltip: 'Удалить',
          ),
        ),
      ),
    ]);
  }).toList();

  @override
  String get title => 'Клиенты';
}