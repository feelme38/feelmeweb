import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/add_device_body.dart';
import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/device_models.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

typedef AddDeviceCallback = void Function(AddDeviceBody);

class AddDeviceDialog extends StatefulWidget {
  const AddDeviceDialog(
      {super.key,
      required this.models,
      required this.powers,
      required this.callback,
      required this.addresses});

  final List<DeviceModelsResponse> models;
  final List<DevicePowersResponse> powers;
  final List<AddressDTO> addresses;
  final AddDeviceCallback callback;

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  late var selectedModel = widget.models.first;
  late var selectedPower = widget.powers.first;
  late var selectedAddress = widget.addresses.first;
  late final controller = TextEditingController()..text = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            Text('Модель оборудования: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                child: DropdownButton(
                    value: selectedModel.id,
                    onChanged: (newValue) {
                      setState(() {
                        selectedModel =
                            widget.models.firstWhere((e) => e.id == newValue);
                      });
                    },
                    items: widget.models.map((e) {
                      return DropdownMenuItem(
                          value: e.id,
                          child: SizedBox(width: 150, child: Text(e.name)));
                    }).toList(),
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 16))),
          ]),
          const SizedBox(height: 6),
          Row(children: [
            Text('Тип питания: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                child: DropdownButton(
                    value: selectedPower.id,
                    onChanged: (newValue) {
                      setState(() {
                        selectedPower =
                            widget.powers.firstWhere((e) => e.id == newValue);
                      });
                    },
                    items: widget.powers.map((e) {
                      return DropdownMenuItem(
                          value: e.id,
                          child: SizedBox(width: 150, child: Text(e.name)));
                    }).toList(),
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 16)))
          ]),
          const SizedBox(height: 6),
          Row(children: [
            Text('Адрес оборудования: ',
                style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                child: DropdownButton(
                    value: selectedAddress.id,
                    onChanged: (newValue) {
                      setState(() {
                        selectedAddress = widget.addresses
                            .firstWhere((e) => e.id == newValue);
                      });
                    },
                    items: widget.addresses.map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.address ?? ''),
                      );
                    }).toList(),
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    isExpanded: true),
              ),
            )
          ]),
          const SizedBox(height: 6),
          BaseTextField(
              controller: controller, helperText: 'GUID оборудования'),
          const SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
                width: context.currentSize.width * 0.33,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                      child: BaseTextButton(
                          buttonText: 'Отмена',
                          onTap: context.navigateUp,
                          enabled: true,
                          buttonColor: Colors.redAccent)),
                  const SizedBox(height: 12, width: 20),
                  Expanded(
                      child: BaseTextButton(
                          buttonText: 'Добавить',
                          onTap: () {
                            context.navigateUp();
                            widget.callback(AddDeviceBody(
                                deviceId: controller.text,
                                modelId: selectedModel.id,
                                addressId: selectedAddress.id,
                                powerId: selectedPower.id));
                          },
                          enabled: true))
                ]))
          ])
        ]));
  }
}
