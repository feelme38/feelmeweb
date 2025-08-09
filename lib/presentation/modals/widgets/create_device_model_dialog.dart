import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/create_device_model_body.dart';
import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';

typedef CreateDeviceModelCallback = void Function(CreateDeviceModelBody);

class CreateDeviceModelDialog extends StatefulWidget {
  const CreateDeviceModelDialog({super.key, required this.callback});

  final CreateDeviceModelCallback callback;

  @override
  State<CreateDeviceModelDialog> createState() =>
      _CreateDeviceModelDialogState();
}

class _CreateDeviceModelDialogState extends State<CreateDeviceModelDialog> {
  final nameController = TextEditingController();
  final listDeviceModelTypes = WorkerType.values;
  late var selectedDeviceModelType = listDeviceModelTypes.first;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: BaseTextField(
                    controller: nameController,
                    helperText: 'Название устройства'),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                  child: DropdownButton<WorkerType>(
                      value: selectedDeviceModelType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDeviceModelType =
                              newValue ?? selectedDeviceModelType;
                        });
                      },
                      items: listDeviceModelTypes.map((e) {
                        return DropdownMenuItem<WorkerType>(
                            value: e,
                            child: SizedBox(width: 150, child: Text(e.name)));
                      }).toList(),
                      focusColor: Colors.white,
                      dropdownColor: Colors.white,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)))
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: context.currentSize.width * 0.4,
            child: Row(
              children: [
                Expanded(
                    child: BaseTextButton(
                        buttonText: 'Отмена',
                        onTap: () {
                          context.navigateUp(arg: true);
                        },
                        enabled: true,
                        buttonColor: Colors.redAccent)),
                const SizedBox(width: 20),
                Expanded(
                  child: BaseTextButton(
                      buttonText: 'Добавить',
                      onTap: () {
                        context.navigateUp();
                        widget.callback(
                          CreateDeviceModelBody(
                              name: nameController.text,
                              worker_type: selectedDeviceModelType),
                        );
                      },
                      enabled: true),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
