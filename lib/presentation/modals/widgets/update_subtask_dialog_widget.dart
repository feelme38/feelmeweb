import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:flutter/material.dart';

typedef UpdateSubtaskCallback = void Function(Subtask subtask);

class UpdateSubtaskDialogWidget extends StatefulWidget {
  final Subtask subtask;
  final LastCheckListInfoResponse checklist;
  final List<Aroma> aromas;
  final List<SubtaskTypeResponse> subtaskTypes;
  final UpdateSubtaskCallback callback;

  const UpdateSubtaskDialogWidget({
    super.key,
    required this.subtask,
    required this.checklist,
    required this.aromas,
    required this.subtaskTypes,
    required this.callback,
  });

  @override
  State<UpdateSubtaskDialogWidget> createState() =>
      _UpdateSubtaskDialogWidgetState();
}

class _UpdateSubtaskDialogWidgetState extends State<UpdateSubtaskDialogWidget> {
  late TextEditingController _commentController;
  late Aroma _selectedAroma;
  late double _selectedVolume;
  late SubtaskTypeResponse _selectedType;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.subtask.comment);
    _selectedAroma = widget.aromas.firstWhere(
      (aroma) => aroma.id == widget.subtask.expectedAroma.id,
    );
    _selectedVolume = widget.subtask.expectedAromaVolume;
    _selectedType = widget.subtaskTypes.firstWhere(
      (type) => type.id == widget.subtask.subtaskType.id,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Редактирование подзадачи',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<Aroma>(
          value: _selectedAroma,
          decoration: const InputDecoration(labelText: 'Аромат'),
          items: widget.aromas
              .map((aroma) => DropdownMenuItem(
                    value: aroma,
                    child: Text(aroma.name),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedAroma = value);
            }
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _commentController,
          decoration: const InputDecoration(labelText: 'Комментарий'),
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<SubtaskTypeResponse>(
          value: _selectedType,
          decoration: const InputDecoration(labelText: 'Тип подзадачи'),
          items: widget.subtaskTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedType = value);
            }
          },
        ),
        const SizedBox(height: 8),
        Slider(
          value: _selectedVolume,
          min: 0,
          max: 100,
          divisions: 100,
          label: _selectedVolume.round().toString(),
          onChanged: (value) {
            setState(() => _selectedVolume = value);
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final updatedSubtask = widget.subtask.copyWith(
                  comment: _commentController.text,
                  expectedAroma: _selectedAroma,
                  expectedAromaVolume: _selectedVolume,
                  subtaskType: _selectedType,
                );
                widget.callback(updatedSubtask);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ],
    );
  }
}
