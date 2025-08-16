import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const InfoRow(
      {super.key, required this.title, required this.value, this.onTap});

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
            child: MouseRegion(
              cursor: onTap != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  value,
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
