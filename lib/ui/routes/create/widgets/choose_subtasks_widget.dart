import 'package:collection/collection.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/ui/routes/create/create_route_view_model.dart';
import 'package:feelmeweb/ui/routes/create/widgets/subtask_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ToggleCustomerCallback = void Function(SubtaskBody);

class CreateRouteChooseSubtasksWidget extends StatefulWidget {
  const CreateRouteChooseSubtasksWidget({
    super.key,
    required this.checklists,
  });

  final List<LastCheckListInfoResponse> checklists;

  @override
  State<CreateRouteChooseSubtasksWidget> createState() =>
      _CreateRouteChooseSubtasksWidgetState();
}

class _CreateRouteChooseSubtasksWidgetState
    extends State<CreateRouteChooseSubtasksWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateRouteViewModel>();
    final selectedCustomers =
        context.watch<CreateRouteViewModel>().selectedCustomers;
    final aromas = context.watch<CreateRouteViewModel>().aromas;
    final taskTypes = context.watch<CreateRouteViewModel>().subtaskTypes;
    final selectedSubtasks =
        context.watch<CreateRouteViewModel>().selectedSubtasks;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.7,
        ),
        itemCount: widget.checklists.length,
        itemBuilder: (context, index) {
          final checklist = widget.checklists[index];
          final customer = selectedCustomers
              .firstWhereOrNull((e) => e.id == checklist.customerId);
          final address = (customer?.addresses ?? [])
              .firstWhereOrNull((e) => e.id == checklist.addressId);
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
    );
  }
}
