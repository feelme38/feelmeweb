
import 'package:flutter/material.dart';

import '../../../data/models/response/customer_response.dart';
import '../../common/app_table_widget.dart';

typedef ToggleCustomerCallback = void Function(CustomerResponse);

class CreateRouteChooseCustomersWidget extends StatefulWidget {

  const CreateRouteChooseCustomersWidget({
    super.key,
    required this.customers,
    required this.selectedCustomers,
    required this.toggleCallback
  });

  final List<CustomerResponse> customers;
  final List<CustomerResponse> selectedCustomers;
  final ToggleCustomerCallback toggleCallback;

  @override
  State<CreateRouteChooseCustomersWidget> createState() => _CreateRouteChooseCustomersWidgetState();
}

class _CreateRouteChooseCustomersWidgetState extends State<CreateRouteChooseCustomersWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AppTableWidget(
        dataColumns: _tableCustomersColumns,
        dataRows: getTableCustomersRows(widget.customers),
      ),
    );
  }

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
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Checkbox(
              value: widget.selectedCustomers.map((e) => e.id).contains(customer.id),
              onChanged: (_) {
                widget.toggleCallback.call(customer);
                setState(() {});
              },
            ),
          )
      ),
    ]);
  }).toList();
}