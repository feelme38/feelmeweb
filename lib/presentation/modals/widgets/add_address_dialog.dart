import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/request/add_customer_address.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/row_select_button.dart';
import 'package:feelmeweb/ui/regions/regions_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/models/response/region_response.dart';
import '../../../domain/address/add_address_usecase.dart';
import '../../widgets/base_text_field.dart';
typedef AddCustomerCallback = void Function(AddCustomerAddressBody);
class AddAddressDialog extends StatefulWidget {
  const AddAddressDialog(
      {super.key, required this.regions, required this.customerId, required this.addCallback});

  final String customerId;
  final AddCustomerCallback addCallback;
  final List<RegionResponse> regions;

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  final controller = TextEditingController();
  final latController = TextEditingController();
  final lonController = TextEditingController();
  late var selectedRegion = widget.regions.first;


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
              Row(
                children: [
                  Expanded(
                      child: BaseTextField(
                          controller: latController,
                          helperText: 'Широта',
                          type: TextInputType.number,
                          formatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\-?\d*\.?\d*)'))
                      ])),
                  const SizedBox(width: 8),
                  Expanded(
                      child: BaseTextField(
                    controller: lonController,
                    helperText: 'Долгота',
                    type: TextInputType.number,
                    formatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^\-?\d*\.?\d*)'))
                    ],
                  )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                      child: DropdownButton(
                          value: selectedRegion.id,
                          onChanged: (newValue) {
                            setState(() {
                              selectedRegion = widget.regions
                                  .firstWhere((e) => e.id == newValue);
                            });
                          },
                          items: widget.regions.map((e) {
                            return DropdownMenuItem(
                                value: e.id,
                                child:
                                    SizedBox(width: 150, child: Text(e.name)));
                          }).toList(),
                          focusColor: Colors.white,
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16))),
                ],
              ),
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
                      buttonColor: Colors.redAccent,
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: BaseTextButton(
                            buttonText: 'Добавить',
                            onTap: () {
                              context.navigateUp();
                              widget.addCallback(AddCustomerAddressBody(
                                  widget.customerId,
                                  selectedRegion.id,
                                  controller.text,
                                  double.parse(latController.text),
                                  double.parse(lonController.text)));
                            },
                            enabled: true))
                  ]))
            ]));
  }
}
