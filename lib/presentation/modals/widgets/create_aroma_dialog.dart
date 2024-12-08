import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/create_aroma_body.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CreateAromaCallback = void Function(CreateAromaBody);

class CreateAromaDialog extends StatefulWidget {
  const CreateAromaDialog({super.key, required this.callback});

  final CreateAromaCallback callback;

  @override
  State<CreateAromaDialog> createState() => _CreateAromaDialogState();
}

class _CreateAromaDialogState extends State<CreateAromaDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BaseTextField(controller: controller, helperText: 'Название аромата'),
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
                      widget.callback(CreateAromaBody(name: controller.text));
                    },
                    enabled: true))
          ]))
    ]);
  }
}
