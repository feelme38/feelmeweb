import 'package:flutter/material.dart';

class ChecklistRow extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;

  const ChecklistRow({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: valueWidget ??
                MouseRegion(
                  cursor: onTap != null
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value ?? "",
                      style: TextStyle(
                          decoration:
                              onTap != null ? TextDecoration.underline : null),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
