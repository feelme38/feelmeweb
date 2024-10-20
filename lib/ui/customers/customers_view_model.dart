
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/domain/customers/get_customers_usecase.dart';
import 'package:flutter/material.dart';

import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_search_view_model.dart';

class CustomersViewModel extends BaseSearchViewModel {

  CustomersViewModel() {
    loadCustomers();
  }

  final _getCustomersUseCase = GetCustomersUseCase();

  List<CustomerResponse> _customers = [];
  List<CustomerResponse> get customers => _customers;

  final List<DataColumn> _tableCustomersColumns = [
    const DataColumn(label: Text('Наименование')),
    const DataColumn(label: Text('Телефон')),
    const DataColumn(label: Text('Директор')),
    const DataColumn(label: Text('Вр. посещения')),
    const DataColumn(label: Text('Адрес')),
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