import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/create_region_body.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';

typedef CreateRegionCallback = void Function(CreateRegionBody);

class CreateRegionDialog extends StatefulWidget {
  const CreateRegionDialog({super.key, required this.callback});

  final CreateRegionCallback callback;

  @override
  State<CreateRegionDialog> createState() => _CreateRegionDialogState();
}

class _CreateRegionDialogState extends State<CreateRegionDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          BaseTextField(
              controller: controller, helperText: 'Наименование района'),
          const SizedBox(height: 12),
          SizedBox(
              width: context.currentSize.width * 0.4,
              child: Row(children: [
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
                          widget
                              .callback(CreateRegionBody(name: controller.text));
                        },
                        enabled: true))
              ]))
        ]));
  }
}
