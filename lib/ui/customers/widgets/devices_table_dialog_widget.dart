
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:flutter/material.dart';

import '../../../data/models/response/device_response.dart';
import '../../common/app_table_widget.dart';

typedef RemoveDeviceCallback = void Function(String);

class DevicesTableDialogWidget extends StatefulWidget {

  const DevicesTableDialogWidget({
    super.key,
    required this.devices,
    required this.removeCallback
  });

  final List<DeviceResponse> devices;
  final RemoveDeviceCallback removeCallback;

  @override
  State<DevicesTableDialogWidget> createState() => _DevicesTableDialogWidgetState();
}

class _DevicesTableDialogWidgetState extends State<DevicesTableDialogWidget> {

  late final devices = widget.devices;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0), // Внутренние отступы
        child: AppTableWidget(
            dataColumns: _tableCustomerDevicesColumns,
            dataRows: _getTableCustomerDevicesRows(devices)
        ),
      ),
    );
  }

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
              widget.removeCallback(device.id);
              setState(() {});
            },
            tooltip: 'Удалить',
          ),
        ),
      ),
    ]);
  }).toList();
}