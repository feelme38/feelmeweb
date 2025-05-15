import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/core/date_utils.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/ui/routes/create/create_route_view_model.dart';
import 'package:feelmeweb/ui/routes/create/widgets/subtask_card_widget.dart';
import 'package:feelmeweb/ui/routes/create/widgets/time_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ToggleCustomerCallback = void Function(SubtaskBody);

class CreateRouteChooseSubtasksWidget extends StatefulWidget {
  const CreateRouteChooseSubtasksWidget({
    super.key,
  });

  @override
  State<CreateRouteChooseSubtasksWidget> createState() =>
      _CreateRouteChooseSubtasksWidgetState();
}

class _CreateRouteChooseSubtasksWidgetState
    extends State<CreateRouteChooseSubtasksWidget> {
  final Map<String, TextEditingController> _timeControllers = {};

  @override
  void dispose() {
    for (final controller in _timeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>();
    final selectedCustomers =
        context.watch<CreateRouteViewModel>().selectedCustomers;
    final aromas = context.watch<CreateRouteViewModel>().aromas;
    final taskTypes = context.watch<CreateRouteViewModel>().subtaskTypes;
    final selectedSubtasks =
        context.watch<CreateRouteViewModel>().selectedSubtasks;
    final checklists = context.watch<CreateRouteViewModel>().lastChecklists;
    final checklistsNotNullId =
        checklists.where((item) => item.id != null).toList();
    final lastDate = checklistsNotNullId.isEmpty
        ? " – "
        : checklistsNotNullId.firstOrNull?.createdAt != null
            ? ruDateFormat.format(checklistsNotNullId.firstOrNull!.createdAt!)
            : '–';

    // Group checklists by customer and address
    final Map<String, Map<String, List<LastCheckListInfoResponse>>>
        groupedChecklists = {};

    for (final checklist in checklists) {
      final customer = selectedCustomers
          .firstWhereOrNull((e) => e.id == checklist.customerId);
      final address = (customer?.addresses ?? [])
          .firstWhereOrNull((e) => e.id == checklist.addressId);

      if (customer != null && address != null) {
        final key = '${customer.id}_${address.id}';
        if (!_timeControllers.containsKey(key)) {
          _timeControllers[key] = TextEditingController();
        }
        groupedChecklists
            .putIfAbsent(customer.id!, () => {})
            .putIfAbsent(address.id!, () => [])
            .add(checklist);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: groupedChecklists.length,
        itemBuilder: (context, customerIndex) {
          final customerId = groupedChecklists.keys.elementAt(customerIndex);
          final customer =
              selectedCustomers.firstWhere((e) => e.id == customerId);
          final addressMap = groupedChecklists[customerId]!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addressMap.length,
            itemBuilder: (context, addressIndex) {
              final addressId = addressMap.keys.elementAt(addressIndex);
              final address =
                  customer.addresses!.firstWhere((e) => e.id == addressId);
              final checklists = addressMap[addressId]!;
              final timeController =
                  _timeControllers['${customer.id}_${address.id}']!;

              final existsTask = viewModel.route?.tasks
                  .firstWhereOrNull((task) => task.client.id == customer.id);

              if (existsTask != null) {
                final newTimeText =
                    DateFormat('HH:mm').format(existsTask.visitDateTime!);
                if (timeController.text != newTimeText) {
                  timeController.text = newTimeText;
                  viewModel.updateVisitTimeForAddress(
                      customerId, addressId, newTimeText);
                }
              }

              return ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                title: Column(
                  children: [
                    Text(customer.name ?? '', textAlign: TextAlign.center),
                    Text(address.address ?? '', textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Время посещения:"),
                        const SizedBox(width: 8),
                        TimeInputField(
                          controller: timeController,
                          onChanged: (_) => viewModel.updateVisitTimeForAddress(
                              customer.id!, address.id!, timeController.text),
                          enabled: existsTask == null,
                        ),
                        const SizedBox(width: 16),
                        Text("Дата последнего посещения: $lastDate"),
                      ],
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.only(top: 8, bottom: 8),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: checklists.length,
                    itemBuilder: (context, index) {
                      final checklist = checklists[index];
                      final subtask = selectedSubtasks.firstWhereOrNull((e) =>
                          e.addressId == checklist.addressId &&
                          e.deviceId == checklist.deviceId);

                      return SubtaskCardWidget(
                        checklist: checklist,
                        aromas: aromas,
                        subtaskTypes: taskTypes,
                        selectedAddress: address,
                        customer: customer,
                        subtask: subtask,
                        createSubtaskCallback: viewModel.toggleSubtaskSelection,
                        deleteSubtaskCallback: () =>
                            viewModel.toggleSubtaskSelection(subtask),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
