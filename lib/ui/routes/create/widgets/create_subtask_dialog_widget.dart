import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/device_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateSubtaskDialogWidget extends StatefulWidget {
  const CreateSubtaskDialogWidget({
    super.key,
    required this.device,
    required this.aromas,
    required this.onSave,
  });

  final DeviceResponse device;
  final List<AromaResponse> aromas;
  final Function(String, String, String, String) onSave;

  @override
  State<CreateSubtaskDialogWidget> createState() =>
      _CreateSubtaskDialogWidgetState();
}

class _CreateSubtaskDialogWidgetState extends State<CreateSubtaskDialogWidget> {
  late final TextEditingController _estimatedTimeController =
      TextEditingController();
  late final TextEditingController _expectedAromaVolumeController =
      TextEditingController();
  late final TextEditingController _commentController = TextEditingController();
  AromaResponse? _selectedAroma;

  @override
  void dispose() {
    _estimatedTimeController.dispose();
    _expectedAromaVolumeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Создание подзадачи',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Устройство: ${widget.device.model.orDash()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AromaResponse>(
                value: _selectedAroma,
                decoration: const InputDecoration(
                  labelText: 'Ожидаемый аромат',
                  border: OutlineInputBorder(),
                ),
                items: widget.aromas.map((aroma) {
                  return DropdownMenuItem(
                    value: aroma,
                    child: Text(aroma.name),
                  );
                }).toList(),
                onChanged: (aroma) {
                  setState(() {
                    _selectedAroma = aroma;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _estimatedTimeController,
                maxLines: 1,
                maxLength: 10,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  labelText: 'Время выполнения (мин)',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expectedAromaVolumeController,
                maxLines: 1,
                maxLength: 10,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  labelText: 'Объем ожидаемого аромата',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentController,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  labelText: 'Комментарий',
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BaseTextButton(
                    buttonText: "Назад",
                    onTap: () => Navigator.of(context).pop(),
                    weight: FontWeight.w500,
                    fontSize: 14,
                    enabled: true,
                    textColor: Colors.white,
                    buttonColor: AppColor.redDefect,
                  ),
                  const SizedBox(width: 16),
                  BaseTextButton(
                    buttonText: "Сохранить",
                    onTap: () {
                      if (_selectedAroma != null &&
                          _estimatedTimeController.text.isNotEmpty &&
                          _expectedAromaVolumeController.text.isNotEmpty) {
                        widget.onSave(
                          _selectedAroma!.id,
                          _estimatedTimeController.text,
                          _expectedAromaVolumeController.text,
                          _commentController.text,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    weight: FontWeight.w500,
                    fontSize: 14,
                    enabled: true,
                    textColor: Colors.white,
                    buttonColor: AppColor.success,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
