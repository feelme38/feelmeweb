import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/add_customer_address.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_text_field.dart';

typedef AddCustomerCallback = void Function(AddCustomerAddressBody);

class AddAddressDialog extends StatefulWidget {
  const AddAddressDialog(
      {super.key, required this.customerId, required this.addCallback});

  final String customerId;
  final AddCustomerCallback addCallback;

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseTextField(
            controller: controller,
            helperText: 'Адрес',
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
                  buttonColor: Colors.redAccent,
                )),
                const SizedBox(width: 20),
                Expanded(
                  child: BaseTextButton(
                      buttonText: 'Добавить',
                      onTap: () {
                        context.navigateUp();
                        widget.addCallback(
                          AddCustomerAddressBody(
                            widget.customerId,
                            controller.text,
                          ),
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
