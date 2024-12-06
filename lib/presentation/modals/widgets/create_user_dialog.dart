import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/core/ui/phone_input_formatter.dart';
import 'package:feelmeweb/data/models/request/add_customer_address.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';

import '../../../data/models/response/region_response.dart';

typedef CreateUserCallback = void Function(CreateUserBody);

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key, required this.createUserCallback});

  final CreateUserCallback createUserCallback;

  @override
  State<CreateUserDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<CreateUserDialog> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final ownerController = TextEditingController();
  final listRegions = List.from(getIt<RegionsRepository>().regions);
  late var selectedRegion = listRegions.first;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseTextField(
                controller: nameController,
                helperText: 'ФИО',
              ),
              const SizedBox(height: 12),
              BaseTextField(
                  controller: ownerController,
                  helperText: 'Директор',
                  type: TextInputType.number),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: BaseTextField(
                        controller: phoneController,
                        helperText: 'Телефон',
                        type: TextInputType.number,
                        formatters: [PhoneInputFormatter()])),
                const SizedBox(width: 8),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                    child: DropdownButton(
                        value: selectedRegion.id,
                        onChanged: (newValue) {
                          setState(() {
                            selectedRegion =
                                listRegions.firstWhere((e) => e.id == newValue);
                          });
                        },
                        items: listRegions.map((e) {
                          return DropdownMenuItem(
                              value: e.id,
                              child: SizedBox(width: 150, child: Text(e.name)));
                        }).toList(),
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)))
              ]),
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
                              widget.createUserCallback(CreateUserBody(
                                  phone: phoneController.text
                                      .replaceAll(' ', '')
                                      .replaceAll('-', '')
                                      .replaceAll('(', '')
                                      .replaceAll(')', '')
                                      .replaceAll('+', ''),
                                  name: nameController.text,
                                  ownerName: ownerController.text,
                                  regionId: selectedRegion.id));
                            },
                            enabled: true))
                  ]))
            ]));
  }
}
