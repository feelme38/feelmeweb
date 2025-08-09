import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/update_aroma_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';

typedef UpdateAromaCallback = void Function(UpdateAromaBody);

class UpdateAromaDialog extends StatefulWidget {
  const UpdateAromaDialog({
    super.key,
    required this.aroma,
    required this.callback,
  });

  final AromaResponse aroma;
  final UpdateAromaCallback callback;

  @override
  State<UpdateAromaDialog> createState() => _UpdateAromaDialogState();
}

class _UpdateAromaDialogState extends State<UpdateAromaDialog> {
  final nameController = TextEditingController();
  final listAromaTypes = AromaType.values;
  late var selectedAromaType = widget.aroma.type ?? AromaType.CLASSIC;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.aroma.name;
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
                    controller: nameController, helperText: 'Название аромата'),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                  child: DropdownButton<AromaType>(
                      value: selectedAromaType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedAromaType = newValue ?? selectedAromaType;
                        });
                      },
                      items: listAromaTypes.map((e) {
                        return DropdownMenuItem<AromaType>(
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
                          UpdateAromaBody(
                              id: widget.aroma.id,
                              name: nameController.text,
                              type: selectedAromaType),
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
