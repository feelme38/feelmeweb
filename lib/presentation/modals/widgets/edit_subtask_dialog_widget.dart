import 'package:collection/collection.dart';
import 'package:feelmeweb/core/constants.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/request/subtask_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/last_checklist_info_response.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/data/models/response/subtask_types_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef EditSubtaskCallback = void Function(SubtaskBody);

class EditSubtaskDialogWidget extends StatefulWidget {
  const EditSubtaskDialogWidget({
    super.key,
    required this.subtask,
    required this.checklist,
    required this.aromas,
    required this.subtaskTypes,
    required this.callback,
  });

  final Subtask subtask;
  final LastCheckListInfoResponse? checklist;
  final List<AromaResponse> aromas;
  final List<SubtaskTypeResponse> subtaskTypes;
  final EditSubtaskCallback callback;

  @override
  State<EditSubtaskDialogWidget> createState() =>
      _EditSubtaskDialogWidgetState();
}

class _EditSubtaskDialogWidgetState extends State<EditSubtaskDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _expectedAromaVolumeController =
      TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  AromaResponse? _selectedAroma;
  String? _selectedAromaFormula;
  SubtaskTypeResponse? _selectedSubtaskType;

  bool _isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _expectedAromaVolumeController.text =
        widget.subtask.expectedAromaVolume.toString();
    _commentController.text = widget.subtask.comment;

    _selectedAroma = widget.aromas
            .firstWhereOrNull((e) => e.id == widget.subtask.expectedAroma.id) ??
        widget.aromas.first;
    _selectedAromaFormula =
        widget.subtask.volumeFormula ?? Constants.aromaFormulasList.first;
    _selectedSubtaskType = widget.subtaskTypes
            .firstWhereOrNull((e) => e.id == widget.subtask.subtaskType.id) ??
        widget.subtaskTypes.first;
  }

  void _validateForm() {
    final isVolumeValid =
        _expectedAromaVolumeController.text.trim().isNotEmpty &&
            num.tryParse(_expectedAromaVolumeController.text) != null &&
            num.tryParse(_expectedAromaVolumeController.text)! > 0;

    final isAromaSelected = _selectedAroma != null;
    final isSubtaskTypeSelected = _selectedSubtaskType != null;
    final isFormulaSelected = _selectedAromaFormula != null;

    final isValid = isVolumeValid &&
        isAromaSelected &&
        isSubtaskTypeSelected &&
        isFormulaSelected;

    if (isValid != _isSaveButtonEnabled) {
      setState(() {
        _isSaveButtonEnabled = isValid;
      });
    }
  }

  @override
  void dispose() {
    _expectedAromaVolumeController.dispose();
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Создание подзадачи',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Устройство: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (widget.checklist?.deviceModel).orDash(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Расположение
            Row(
              children: [
                Text(
                  'Расположение: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (widget.checklist?.deviceLocation).orDash(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Режим работы
            Row(
              children: [
                Text(
                  'Режим работы: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Режим работы',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Тип сотрудничества
            Row(
              children: [
                Text(
                  'Тип сотрудничества: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (widget.checklist?.contract).orDash(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Текущий аромат
            Row(
              children: [
                Text(
                  'Текущий аромат: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (widget.checklist?.checklistAroma.newAromaName).orDash(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Остаток аромата
            Row(
              children: [
                Text(
                  'Остаток аромата: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    (widget.checklist?.checklistAroma.volumeMl.toString())
                        .orDash(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            /// Подзадача
            Row(
              children: [
                Text(
                  'Тип подзадачи: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                DropdownButton<SubtaskTypeResponse>(
                  value: _selectedSubtaskType,
                  items: widget.subtaskTypes.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: SizedBox(width: 150, child: Text(e.name)),
                    );
                  }).toList(),
                  onChanged: (type) {
                    setState(() {
                      _selectedSubtaskType = type;
                    });
                    _validateForm();
                  },
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Аромат
            Row(
              children: [
                Text(
                  'Ожидаемый аромат: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                DropdownButton<AromaResponse>(
                  value: _selectedAroma,
                  hint: const Text('Выберите аромат'),
                  items: widget.aromas.map((aroma) {
                    return DropdownMenuItem(
                      value: aroma,
                      child: SizedBox(width: 150, child: Text(aroma.name)),
                    );
                  }).toList(),
                  onChanged: (aroma) {
                    setState(() {
                      _selectedAroma = aroma;
                    });
                    _validateForm();
                  },
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 6),

            /// Объем аромата
            Row(
              children: [
                Text(
                  'Объем аромата: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BaseTextField(
                    controller: _expectedAromaVolumeController,
                    type: const TextInputType.numberWithOptions(decimal: true),
                    formatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    onTextChange: (_) => _validateForm(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            /// Формула
            Row(
              children: [
                Text(
                  'Формула: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedAromaFormula,
                  hint: const Text('Выберите формулу'),
                  items: Constants.aromaFormulasList.map((volumeFormula) {
                    return DropdownMenuItem(
                      value: volumeFormula,
                      child: SizedBox(width: 150, child: Text(volumeFormula)),
                    );
                  }).toList(),
                  onChanged: (volumeFormula) {
                    if (volumeFormula != null) {
                      setState(() {
                        _selectedAromaFormula = volumeFormula;
                      });
                      _validateForm();
                    }
                  },
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 6),

            /// Комментарий
            Row(
              children: [
                Text(
                  'Комментарий: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: BaseTextField(
                      controller: _commentController,
                      minLines: 1,
                      maxLines: null),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Кнопки
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: BaseTextButton(
                    buttonText: "Назад",
                    onTap: context.navigateUp,
                    enabled: true,
                    buttonColor: AppColor.redDefect,
                  ),
                ),
                SizedBox(width: context.currentSize.width * 0.2),
                Expanded(
                  child: BaseTextButton(
                    buttonText: "Сохранить",
                    onTap: () {
                      if (_isSaveButtonEnabled) {
                        context.navigateUp();
                        widget.callback(
                          SubtaskBody(
                              widget.checklist!.customerId,
                              widget.checklist!.deviceId!,
                              _commentController.text,
                              _selectedAroma!.id,
                              double.parse(_expectedAromaVolumeController.text),
                              _selectedAromaFormula!,
                              _selectedSubtaskType!.id,
                              id: widget.subtask.id,
                              addressId: widget.checklist!.addressId,
                              subtaskStatus: widget.subtask.subtaskStatus),
                        );
                      }
                    },
                    enabled: _isSaveButtonEnabled,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
