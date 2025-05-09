import 'package:feelmeweb/core/formatters/time_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool enabled;

  const TimeInputField(
      {super.key,
      required this.controller,
      this.onChanged,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      width: 100,
      child: TextFormField(
          controller: controller,
          maxLength: 5,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Только цифры
            TimeInputFormatter(),
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            enabled: enabled,
            hintText: '00:00',
            counterText: "",
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          onChanged: onChanged),
    );
  }
}
