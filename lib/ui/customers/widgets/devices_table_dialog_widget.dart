import 'package:base_class_gen/core/ext/build_context_ext.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';

import '../../../data/models/response/device_response.dart';
import '../../../presentation/buttons/base_text_button.dart';
import '../../../presentation/theme/theme_colors.dart';
import '../../common/app_table_widget.dart';

typedef RemoveDeviceCallback = void Function(String, int);

class DevicesTableDialogWidget extends StatefulWidget {
  const DevicesTableDialogWidget(
      {super.key,
      required this.devices,
      required this.removeCallback,
      required this.powers,
      required this.models});

  final List<DevicePowersResponse> powers;
  final List<DeviceModelsResponse> models;
  final List<DeviceResponse> devices;
  final RemoveDeviceCallback removeCallback;

  @override
  State<DevicesTableDialogWidget> createState() =>
      _DevicesTableDialogWidgetState();
}

class _DevicesTableDialogWidgetState extends State<DevicesTableDialogWidget> {
  late final devices = List<DeviceResponse>.from(widget.devices);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0), // Внутренние отступы
            child: Column(children: [
              AppTableWidget(
                  dataColumns: _tableCustomerDevicesColumns,
                  dataRows: _getTableCustomerDevicesRows(devices)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 0.0, 32),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    SizedBox(
                        width: context.currentSize.width * 0.25,
                        child: BaseTextButton(
                          buttonText: "Добавить оборудование",
                          onTap: () {
                            context.navigateUp();
                            Dialogs.createDeviceDialog(
                                context, widget.powers, widget.models);
                          },
                          weight: FontWeight.w500,
                          fontSize: 14,
                          textColor: Colors.white,
                          enabled: true,
                        ))
                  ]))
            ])));
  }

  final List<DataColumn> _tableCustomerDevicesColumns = [
    const DataColumn(
        label: Text('Модель'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Аромат'), headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Остаток аромата'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Тип питания'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(
        label: Text('Тип сотрудничества'),
        headingRowAlignment: MainAxisAlignment.center),
    const DataColumn(label: Text('')),
  ];

  List<DataRow> _getTableCustomerDevicesRows(List<DeviceResponse> devices) =>
      devices.map((device) {
        return DataRow(cells: [
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(device.model.orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text((device.aroma?.name).orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text((device.aromaVolume?.toString()).orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(device.powerType.orDash()),
          )),
          DataCell(Align(
            alignment: Alignment.center,
            child: Text(device.contract.orDash()),
          )),
          DataCell(
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  devices.removeWhere((e) => e.id == device.id);
                  widget.removeCallback(device.id, devices.length);
                  setState(() {});
                },
                tooltip: 'Удалить',
              ),
            ),
          ),
        ]);
      }).toList();
}
