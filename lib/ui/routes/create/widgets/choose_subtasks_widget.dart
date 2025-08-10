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
  final Map<String, TextEditingController> _fromControllers = {};
  final Map<String, TextEditingController> _toControllers = {};
  final Map<String, bool> _toErrors = {};

  @override
  void dispose() {
    for (final controller in _fromControllers.values) {
      controller.dispose();
    }
    for (final controller in _toControllers.values) {
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
        if (!_fromControllers.containsKey(key)) {
          _fromControllers[key] = TextEditingController();
        }
        if (!_toControllers.containsKey(key)) {
          _toControllers[key] = TextEditingController();
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
              final key = '${customer.id}_${address.id}';
              final fromController = _fromControllers[key]!;
              final toController = _toControllers[key]!;

              final fromTime =
                  viewModel.visitFromTimes['${customer.id}_${address.id}'];
              final toTime =
                  viewModel.visitToTimes['${customer.id}_${address.id}'];
              if (fromTime != null) {
                final fromText = DateFormat('HH:mm').format(fromTime);
                if (fromController.text != fromText) {
                  fromController.text = fromText;
                }
              }
              if (toTime != null) {
                final toText = DateFormat('HH:mm').format(toTime);
                if (toController.text != toText) {
                  toController.text = toText;
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
                          controller: fromController,
                          onChanged: (v) {
                            viewModel.updateVisitTimeFrom(
                                customer.id!, address.id!, v);
                            // if TO already selected and < FROM -> snap TO to FROM
                            final from = DateUtil.parseTime(v);
                            final to = DateUtil.parseTime(toController.text);
                            if (from != null && to != null && to.isBefore(from)) {
                              toController.clear();
                              _toErrors[key] = true;
                              setState(() {});
                            }
                            if (from != null && to != null && !to.isBefore(from)) {
                              _toErrors[key] = false;
                              setState(() {});
                            }
                          },
                          enabled: true,
                          onTap: () async {
                            final now = TimeOfDay.now();
                            final from = await showTimePicker(
                              context: context,
                              initialTime: now,
                              builder: (context, child) => MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child ?? const SizedBox.shrink(),
                              ),
                            );
                            if (from == null) return;
                            String two(int v) => v.toString().padLeft(2, '0');
                            final fromStr = '${two(from.hour)}:${two(from.minute)}';
                            fromController.text = fromStr;
                            viewModel.updateVisitTimeFrom(
                                customer.id!, address.id!, fromStr);

                            final to = DateUtil.parseTime(toController.text);
                            final fromDt = DateUtil.parseTime(fromStr);
                            if (fromDt != null && to != null && to.isBefore(fromDt)) {
                              toController.clear();
                              _toErrors[key] = true;
                              setState(() {});
                            } else {
                              _toErrors[key] = false;
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        const Text('—'),
                        const SizedBox(width: 12),
                        TimeInputField(
                          controller: toController,
                          hasError: _toErrors[key] ?? false,
                          onChanged: (v) {
                            final from = DateUtil.parseTime(fromController.text);
                            final to = DateUtil.parseTime(v);
                            if (from != null && to != null && to.isBefore(from)) {
                              toController.clear();
                              _toErrors[key] = true;
                              setState(() {});
                            } else {
                              viewModel.updateVisitTimeTo(
                                  customer.id!, address.id!, v);
                              _toErrors[key] = false;
                              setState(() {});
                            }
                          },
                          enabled: true,
                          onTap: () async {
                            final now = TimeOfDay.now();
                            final to = await showTimePicker(
                              context: context,
                              initialTime: now,
                              builder: (context, child) => MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child ?? const SizedBox.shrink(),
                              ),
                            );
                            if (to == null) return;
                            String two(int v) => v.toString().padLeft(2, '0');
                            final toStr = '${two(to.hour)}:${two(to.minute)}';
                            final from = DateUtil.parseTime(fromController.text);
                            final toDt = DateUtil.parseTime(toStr);
                            if (from != null && toDt != null && toDt.isBefore(from)) {
                              toController.clear();
                              _toErrors[key] = true;
                              setState(() {});
                            } else {
                              toController.text = toStr;
                              viewModel.updateVisitTimeTo(
                                  customer.id!, address.id!, toStr);
                              _toErrors[key] = false;
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(width: 16),
                        Text("Дата последнего посещения: $lastDate"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        maxLength: 500,
                        decoration: const InputDecoration(
                          hintText: 'Комментарий к посещению',
                          counterText: '',
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        onChanged: (value) => viewModel.updateTaskComment(
                            customer.id!, address.id!, value),
                      ),
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
