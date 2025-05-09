import 'package:collection/collection.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:flutter/material.dart';

import 'edit_subtask_card_widget.dart';

class EditSubtasksWidget extends StatelessWidget {
  const EditSubtasksWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.4,
      ),
      itemCount: task.subtasks.length,
      itemBuilder: (context, index) {
        final subtask = task.subtasks[index];
        final checklist = task.checkListInfo.firstWhereOrNull(
          (e) => e.deviceId == subtask.device.id,
        );

        if (checklist == null) return const SizedBox.shrink();

        return EditSubtaskCardWidget(
            checklist: checklist, task: task, subtask: subtask);
      },
    );
  }
}
