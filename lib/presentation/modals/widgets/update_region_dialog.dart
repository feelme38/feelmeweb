import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/update_region_body.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';

typedef UpdateRegionCallback = void Function(UpdateRegionBody);

class UpdateRegionDialog extends StatefulWidget {
  const UpdateRegionDialog(
      {super.key, required this.region, required this.callback});

  final RegionResponse region;
  final UpdateRegionCallback callback;

  @override
  State<UpdateRegionDialog> createState() => _UpdateRegionDialogState();
}

class _UpdateRegionDialogState extends State<UpdateRegionDialog> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.region.name;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseTextField(
              controller: controller, helperText: 'Наименование района'),
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
                          UpdateRegionBody(
                              regionId: widget.region.id,
                              name: controller.text),
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
