import 'package:base_class_gen/core/ext/build_context_ext.dart';
import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_address_dialog.dart';

class AddressesDialog extends StatelessWidget {
  const AddressesDialog(
      {super.key,
      required this.addresses,
      required this.regions,
      required this.customerId,
      required this.addCustomerCallback,
      required this.fromContext});

  final BuildContext fromContext;
  final List<AddressDTO> addresses;
  final List<RegionResponse> regions;
  final String customerId;
  final AddCustomerCallback addCustomerCallback;

  // final AddAddressCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Text('Адреса',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none)),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final element = addresses[index];
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(element.address ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              fontSize: 18)),
                      regions.isEmpty ? const SizedBox() : IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          //TODO: сделать удаление как для девайсов
                          // devices.removeWhere((e) => e.id == device.id);
                          // widget.removeCallback(device.id, devices.length);
                          // setState(() {});
                        },
                        tooltip: 'Удалить',
                      )
                    ]);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: addresses.length),
          const SizedBox(height: 24),
          Builder(
            builder: (context) {
              return regions.isEmpty ? const SizedBox() : SizedBox(
                width: context.currentSize.width * 0.2,
                child: BaseTextButton(
                    buttonText: 'Добавить новый адрес',
                    onTap: () {
                      context.navigateUp();
                      Dialogs.showBaseDialog(
                        context,
                        AddAddressDialog(
                            regions: regions,
                            customerId: customerId,
                            addCallback: addCustomerCallback),
                        width: context.currentSize.width * 0.4,
                      ).then((value) {
                        if (value == true) {
                          Dialogs.showAddressesDialog(fromContext, addresses,
                              regions, addCustomerCallback, customerId);
                        }
                      });
                    },
                    enabled: true),
              );
            }
          )
        ]);
  }
}
