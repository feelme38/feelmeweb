import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:flutter/material.dart';

import 'checklist_info.dart';

class ChecklistDetailsPanel extends StatelessWidget {
  final ChecklistResponseItem? checklist;

  const ChecklistDetailsPanel({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey.shade300)),
      ),
      child: checklist == null
          ? const Center(child: Text("Чек-лист не выбран"))
          : ChecklistInfo(checklist: checklist!),
    );
  }
}
