import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/update_device_model_body.dart';
import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:feelmeweb/data/models/response/device_models.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';

typedef UpdateDeviceModelCallback = void Function(UpdateDeviceModelBody);

class UpdateDeviceModelDialog extends StatefulWidget {
  const UpdateDeviceModelDialog(
      {super.key, required this.deviceModel, required this.callback});

  final DeviceModelsResponse deviceModel;
  final UpdateDeviceModelCallback callback;

  @override
  State<UpdateDeviceModelDialog> createState() =>
      _UpdateDeviceModelDialogState();
}

class _UpdateDeviceModelDialogState extends State<UpdateDeviceModelDialog> {
  final nameController = TextEditingController();
  final listDeviceModelTypes = WorkerType.values;
  late var selectedDeviceModelType = listDeviceModelTypes.first;

  @override
  void initState() {
    nameController.text = widget.deviceModel.name;
    selectedDeviceModelType =
        widget.deviceModel.worker_type ?? listDeviceModelTypes.first;
    super.initState();
  }

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
                      buttonText: 'Обновить',
                      onTap: () {
                        context.navigateUp();
                        widget.callback(
                          UpdateDeviceModelBody(
                              id: widget.deviceModel.id,
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
