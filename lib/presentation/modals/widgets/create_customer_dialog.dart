import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/core/ui/phone_input_formatter.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/repository/regions/regions_repository.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';


typedef CreateCustomerCallback = void Function(CreateCustomerBody);

class CreateCustomerDialog extends StatefulWidget {
  const CreateCustomerDialog({super.key, required this.createUserCallback});

  final CreateCustomerCallback createUserCallback;

  @override
  State<CreateCustomerDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<CreateCustomerDialog> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final ownerController = TextEditingController();
  final addressController = TextEditingController();
  final List<String> _allAddressSamples = const [
    'Москва, Тверская улица, 1',
    'Москва, Новый Арбат, 10',
    'Санкт-Петербург, Невский проспект, 20',
    'Казань, Кремлёвская, 5',
  ];
  List<String> _addressSuggestions = [];
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
                helperText: 'Наименование организации',
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
              BaseTextField(
                controller: addressController,
                helperText: 'Адрес',
                onTextChange: _onAddressChanged,
              ),
              if (_addressSuggestions.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black54, width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _addressSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _addressSuggestions[index];
                      return ListTile(
                        dense: true,
                        title: Text(suggestion),
                        onTap: () {
                          setState(() {
                            addressController.text = suggestion;
                            _addressSuggestions = [];
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
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
                              widget.createUserCallback(CreateCustomerBody(
                                  phone: phoneController.text
                                      .replaceAll(' ', '')
                                      .replaceAll('-', '')
                                      .replaceAll('(', '')
                                      .replaceAll(')', '')
                                      .replaceAll('+', ''),
                                  name: nameController.text,
                                  ownerName: ownerController.text,
                                  regionId: selectedRegion.id,
                                  address: addressController.text));
                            },
                            enabled: true))
                  ]))
            ]));
  }

  void _onAddressChanged(String value) {
    // Stub: local filtering to mimic suggestions until API is integrated
    setState(() {
      if (value.isEmpty) {
        _addressSuggestions = [];
      } else {
        _addressSuggestions = _allAddressSamples
            .where((e) => e.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }
}