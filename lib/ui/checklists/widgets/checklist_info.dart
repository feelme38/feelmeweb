import 'dart:html' as html;

import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/data/models/response/pagination_checklists_response.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklist_row.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklists_helper.dart';
import 'package:flutter/material.dart';

class ChecklistInfo extends StatelessWidget {
  final ChecklistResponseItem checklist;

  const ChecklistInfo({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Информация о чек-листе",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ChecklistRow(title: "Дата создания", value: checklist.createdAtDate),
        ChecklistRow(title: "Адрес", value: checklist.address.address),
        ChecklistRow(
            title: "Как ощущается",
            value: AromaFeelExtension.fromString(checklist.aromaFeel)
                    ?.displayName ??
                '-'),
        ChecklistRow(
            title: "Тип сотрудничества",
            value: checklist.actionCause.displayName),
        ChecklistRow(
            title: "Действие",
            value: checklist.aromaAction == AromaAction.REFILLED
                ? checklist.subtask?.device.aroma?.name ?? '-'
                : checklist.newAroma.name),
        ChecklistRow(
            title: "Режим работы",
            value: ChecklistsHelper.formatWorkSchedule(checklist.workSchedule)),
        ChecklistRow(
          title: "Вложения",
          value: ChecklistsHelper.pluralizeAttachments(
              checklist.attachments.length),
          onTap: () => _showAttachmentsModal(context, checklist.attachments),
        ),
        ChecklistRow(title: "Тип питания", value: checklist.powerType.name),
        ChecklistRow(title: "Аромат", value: checklist.newAroma.name),
      ],
    );
  }
}

void _showAttachmentsModal(BuildContext context, List<Attachment> attachments) {
  Dialogs.showBaseDialog(
    context,
    Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Вложения",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: attachments.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // три файла в ряд
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final att = attachments[index];
                final isImage = att.url.endsWith(".jpg") ||
                    att.url.endsWith(".png") ||
                    att.url.endsWith(".jpeg") ||
                    att.url.endsWith(".webp");

                if (isImage) {
                  return GestureDetector(
                    onTap: () => html.window.open(att.url, '_blank'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        att.url,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.error),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: IconButton(
                      icon: const Icon(Icons.insert_drive_file_outlined),
                      tooltip: "Открыть файл",
                      onPressed: () => html.window.open(att.url, '_blank'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
    width: context.currentSize.width * 0.6,
  );
}
